From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH] mfd: twl4030: Driver for twl4030 madc module
Date: Tue, 1 Dec 2009 11:19:48 +0100
Message-ID: <20091201101945.GA6492@sortiz.org>
References: <1259146071-2372-1-git-send-email-amit.kucheria@verdurent.com>
 <20091127193636.GA16866@sortiz.org>
 <37786d4b0911300558i984d2bdj9b0c5617503c1950@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.21]:59731 "EHLO
	orsmga101.jf.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754015AbZLAKSF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Dec 2009 05:18:05 -0500
Content-Disposition: inline
In-Reply-To: <37786d4b0911300558i984d2bdj9b0c5617503c1950@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Amit Kucheria <amit.kucheria@verdurent.com>
Cc: List Linux Kernel <linux-kernel@vger.kernel.org>, linux-omap@vger.kernel.org, Mikko Ylinen <mikko.k.ylinen@nokia.com>, khali@linux-fr.org

Hi Amit,

On Mon, Nov 30, 2009 at 03:58:39PM +0200, Amit Kucheria wrote:
> >> + * drivers/i2c/chips/twl4030-madc.c
> > drivers/mfd/twl4030-madc.c
> > By the way, have you considered moving this one to drivers/hwmon ?
>=20
> I haven't. I moved it from i2c/chips/ to the most obvious place I
> could think of - drivers/mfd. But wasn't this the point of mfd - that
> various subcomponents drivers could live there instead of being
> scattered across the driver tree?
Not really. Most of the drivers in mfd/ are for the core parts of the
corresponding chip (chip init and setup, subdevices definitions and
declarations, API export, IRQ setups, etc...).
I can take this driver for now, but converting it to a proper hwmon dri=
ver
would make sense because that's what it is after all.


> >> +static struct twl4030_madc_data *the_madc;
> > I dont particularly enjoy that. All of the twl4030 drivers have thi=
s bad habit
> > of assuming they will be alone on a platform. Although it's certain=
ly very
> > likely, I still think having this kind of design is not so nice.
>=20
> I agree. Unfortunately, twl4030-core.c is unable to handle multiple
> devices currently. See note from line 779 in twl4030-core below:
Oh, I know about that. That's also something the code maintainers (Noki=
a I
assume) of that driver should start looking at.

=20
> >> +static int twl4030_madc_read(struct twl4030_madc_data *madc, u8 r=
eg)
> >> +{
> >> + =A0 =A0 int ret;
> >> + =A0 =A0 u8 val;
> >> +
> >> + =A0 =A0 ret =3D twl4030_i2c_read_u8(TWL4030_MODULE_MADC, &val, r=
eg);
> >> + =A0 =A0 if (ret) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(madc->dev, "unable to read regis=
ter 0x%X\n", reg);
> >> + =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> >> + =A0 =A0 }
> >> +
> >> + =A0 =A0 return val;
> >> +}
> > FWIW, you're not checking the return value on any of the madc_read =
calls
> > below.
>=20
> I've changed the dev_dbg above to dev_err now. If we see those error
> messages, then anything that follows from the higher level functions
> is overhead IMHO.
I usually expect code to check for function return values :) And also e=
xit if
a IO fails.


> The higher level functions in this case aren't adding any more useful
> information to the error. E.g. I could check the return value again i=
n
> twl4030_madc_channel_raw_read() below. But if would simply repeat the
> same error message we show in twl4030_madc_read().
The error message matter less than the code flow itself. For example if
twl4030_madc_start_conversion() fails because of your i2c failing, you =
will
still busy loop (Yes, only for 5ms, but still) waiting for a register b=
it to
toggle.
=20
> Hmm, perhaps twl4030_madc_read should return void?
That would be weird, imho. In fact, your write routine returning void i=
s
already weird.


> >> +static void twl4030_madc_work(struct work_struct *ws)
> >> +{
> >> + =A0 =A0 const struct twl4030_madc_conversion_method *method;
> >> + =A0 =A0 struct twl4030_madc_data *madc;
> >> + =A0 =A0 struct twl4030_madc_request *r;
> >> + =A0 =A0 int len, i;
> >> +
> >> + =A0 =A0 madc =3D container_of(ws, struct twl4030_madc_data, ws);
> >> + =A0 =A0 mutex_lock(&madc->lock);
> >> +
> >> + =A0 =A0 for (i =3D 0; i < TWL4030_MADC_NUM_METHODS; i++) {
> >> +
> >> + =A0 =A0 =A0 =A0 =A0 =A0 r =3D &madc->requests[i];
> >> +
> >> + =A0 =A0 =A0 =A0 =A0 =A0 /* No pending results for this method, m=
ove to next one */
> >> + =A0 =A0 =A0 =A0 =A0 =A0 if (!r->result_pending)
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
> >> +
> >> + =A0 =A0 =A0 =A0 =A0 =A0 method =3D &twl4030_conversion_methods[r=
->method];
> >> +
> >> + =A0 =A0 =A0 =A0 =A0 =A0 /* Read results */
> >> + =A0 =A0 =A0 =A0 =A0 =A0 len =3D twl4030_madc_read_channels(madc,=
 method->rbase,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0r->channels, r->rbuf);
> >> +
> >> + =A0 =A0 =A0 =A0 =A0 =A0 /* Return results to caller */
> >> + =A0 =A0 =A0 =A0 =A0 =A0 if (r->func_cb !=3D NULL) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 r->func_cb(len, r->chann=
els, r->rbuf);
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 r->func_cb =3D NULL;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 }
> >> +
> >> + =A0 =A0 =A0 =A0 =A0 =A0 /* Free request */
> >> + =A0 =A0 =A0 =A0 =A0 =A0 r->result_pending =3D 0;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 r->active =A0 =A0 =A0 =A0 =3D 0;
> >> + =A0 =A0 }
> >> +
> >> + =A0 =A0 mutex_unlock(&madc->lock);
> >> +}
> > I think you may want to consider using a threaded irq here, see
> > request_threaded_irq().
>=20
> I am working on moving the entire twl* driver set to use threaded irq=
s
> on the side. Will you consider merging this code with the work_struct
> since it is known to work while I work on the conversion?
That's fine, yes. Thanks in advance for the conversion.

=20
> >> +static int twl4030_madc_set_power(struct twl4030_madc_data *madc,=
 int on);
> >> +int twl4030_madc_conversion(struct twl4030_madc_request *req)
> >> +{
> >> + =A0 =A0 const struct twl4030_madc_conversion_method *method;
> >> + =A0 =A0 u8 ch_msb, ch_lsb;
> >> + =A0 =A0 int ret;
> >> +
> >> + =A0 =A0 if (unlikely(!req))
> >> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> >> +
> >> + =A0 =A0 mutex_lock(&the_madc->lock);
> >> +
> >> + =A0 =A0 twl4030_madc_set_power(the_madc, 1);
> >> +
> >> + =A0 =A0 /* Do we have a conversion request ongoing */
> >> + =A0 =A0 if (the_madc->requests[req->method].active) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EBUSY;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> >> + =A0 =A0 }
> >> +
> >> + =A0 =A0 ch_msb =3D (req->channels >> 8) & 0xff;
> >> + =A0 =A0 ch_lsb =3D req->channels & 0xff;
> >> +
> >> + =A0 =A0 method =3D &twl4030_conversion_methods[req->method];
> >> +
> >> + =A0 =A0 /* Select channels to be converted */
> >> + =A0 =A0 twl4030_madc_write(the_madc, method->sel + 1, ch_msb);
> >> + =A0 =A0 twl4030_madc_write(the_madc, method->sel, ch_lsb);
> >> +
> >> + =A0 =A0 /* Select averaging for all channels if do_avg is set */
> >> + =A0 =A0 if (req->do_avg) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 twl4030_madc_write(the_madc, method->avg=
 + 1, ch_msb);
> >> + =A0 =A0 =A0 =A0 =A0 =A0 twl4030_madc_write(the_madc, method->avg=
, ch_lsb);
> >> + =A0 =A0 }
> >> +
> >> + =A0 =A0 if ((req->type =3D=3D TWL4030_MADC_IRQ_ONESHOT) && (req-=
>func_cb !=3D NULL)) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 twl4030_madc_set_irq(the_madc, req);
> >> + =A0 =A0 =A0 =A0 =A0 =A0 twl4030_madc_start_conversion(the_madc, =
req->method);
> >> + =A0 =A0 =A0 =A0 =A0 =A0 the_madc->requests[req->method].active =3D=
 1;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D 0;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> >> + =A0 =A0 }
> >> +
> >> + =A0 =A0 /* With RT method we should not be here anymore */
> >> + =A0 =A0 if (req->method =3D=3D TWL4030_MADC_RT) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> >> + =A0 =A0 }
> >> +
> >> + =A0 =A0 twl4030_madc_start_conversion(the_madc, req->method);
> >> + =A0 =A0 the_madc->requests[req->method].active =3D 1;
> >> +
> >> + =A0 =A0 /* Wait until conversion is ready (ctrl register returns=
 EOC) */
> >> + =A0 =A0 ret =3D twl4030_madc_wait_conversion_ready(the_madc, 5, =
method->ctrl);
> > So, you're busy looping with all conversions ? I have no idea how o=
ften this
> > is called, but putting the caller to sleep on e.g. a waitqueue woul=
d be more
> > elegant.
>=20
> I suspect this was done for latency reasons since this is used for
> battery charging software.
> Mikko can you comment on this?
I'd be curious to know, yes :)


> >> +EXPORT_SYMBOL(twl4030_madc_conversion);
> > Who's supposed to use this one ?
>=20
> Nokia AV accessory detection code uses this. So does the BCI battery
> driver from TI. The BCI driver has been removed from the omap tree
> pending the merge of the madc driver upstream.
Ok, cool then.

> >> +struct twl4030_madc_request {
> >> + =A0 =A0 u16 channels;
> >> + =A0 =A0 u16 do_avg;
> >> + =A0 =A0 u16 method;
> >> + =A0 =A0 u16 type;
> >> + =A0 =A0 int active;
> >> + =A0 =A0 int result_pending;
> > active and result_pending can be bool.
Could you please fix this one as well ?

Cheers,
Samuel.

--=20
Intel Open Source Technology Centre
http://oss.intel.com/
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
