From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 1/4] MFD: twl4030: add twl4030_codec MFD as
	a new child to the core
Date: Thu, 22 Oct 2009 09:04:32 +0300
Message-ID: <200910220904.32676.peter.ujfalusi@nokia.com>
References: <1255956140-4829-1-git-send-email-peter.ujfalusi@nokia.com>
	<1255956140-4829-2-git-send-email-peter.ujfalusi@nokia.com>
	<20091021231311.GF17796@sortiz.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20091021231311.GF17796@sortiz.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Samuel Ortiz <sameo@linux.intel.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>
List-Id: linux-omap@vger.kernel.org

On Thursday 22 October 2009 02:13:11 ext Samuel Ortiz wrote:
> As Mark noticed already, you dont really want users to explicitely select
>  this obscure mfd driver to get their audio and vibre driver selectable. =
It
>  should be the other way around, and I think you already agreed with that.

Yes, I have already made the modification.

> =

> > +static struct device *
> > +twl4030_codec_new_child(const char *name, void *pdata, unsigned
> > pdata_len) +{

...
 =

> This could really use the mfd-core API, and avoid duplicating code.
> You just would have to define a couple cells, and call mfd_add_devices on
> them.

Good point. When I wrote this driver I have been looking at the twl4030-cor=
e =

driver, which is not using the mfd-core API. I'll make the change.

> =

> > +static int __devexit twl4030_codec_remove(struct platform_device *pdev)
> > +{
> > +	struct twl4030_codec *codec =3D platform_get_drvdata(pdev);
> > +
> > +	platform_set_drvdata(pdev, NULL);
> > +	kfree(codec);
> > +	twl4030_codec_dev =3D NULL;
> > +
> > +	return 0;
> > +}
> =

> I think you're missing a platform_device_unregister() here (or an
> mfd_remove_devices() if you're going to switch to the mfd-core API)

You are right, although I have used the bool in the Kconfig for the twl4030-
codec in a same way as the twl4030-core (and the core did not unregister th=
e =

devices either), but yes, this is not correct so I'll fix it.

I have now question about the practicalities on how this series would be ta=
ken, =

and via which tree.
The final patch for the soc codec driver depends on the change in MFD and i=
n the =

OMAP board files.
The change in the OMAP board files depends on the MFD changes, obviously.

So in order to have the soc codec changes the MFD and OMAP part has to be =

applied before, otherwise the audio will be broken.

the mfd-2.6:for-next branch has some patches against the twl4030-core in =

addition to the ones in l-o and in sound-2.6:topic/asoc.

I'll check, if the MFD patch applies to mfd-2.6:for-next also, but to have =
the =

soc codec changes the MFD patch should go to the sound-2.6 tree as well to =
make =

sure it is not braking things.

All-in-all, how these things can be handled?

Thanks, =

P=E9ter
