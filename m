From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Subject: Re: OMAP support in mainline?
Date: Sat, 20 Sep 2008 02:48:10 +0100
Message-ID: <yw1xprmzsi3p.fsf@thrashbarg.mansr.com>
References: <87tzcgi1gv.fsf@nokia.com> <20080916232505.GC25885@atomide.com> <20080917082043.04c94e2d.jarkko.nikula@nokia.com> <200809162255.00918.david-b@pacbell.net> <9934E327-66E0-48DF-9FB6-FFF828E5358B@student.utwente.nl> <5e088bd90809170524s6cfae9b9ye1379f11afb5bb79@mail.gmail.com> <8192948C-751F-4C1C-B382-E381F903CC46@student.utwente.nl> <20080918095537.GD28615@gandalf.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:52602 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751153AbYITBsa (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 19 Sep 2008 21:48:30 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Kgra9-0002hA-KM
	for linux-omap@vger.kernel.org; Sat, 20 Sep 2008 01:48:21 +0000
Received: from thrashbarg.mansr.com ([78.86.181.100])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Sat, 20 Sep 2008 01:48:21 +0000
Received: from mans by thrashbarg.mansr.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Sat, 20 Sep 2008 01:48:21 +0000
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

=46elipe Balbi <felipe.balbi@nokia.com> writes:

> On Wed, Sep 17, 2008 at 03:23:49PM +0200, ext Koen Kooi wrote:
>>
>> Op 17 sep 2008, om 14:24 heeft Steve Sakoman het volgende geschreven=
:
>>
>>> On Wed, Sep 17, 2008 at 12:16 AM, Koen Kooi <k.kooi@student.utwente=
=2Enl>=20
>>> wrote:
>>>
>>>> And they aren't working too well with current l-o git either with =
MUSB=20
>>>> being
>>>> broken. There's a patch to fix client mode, but host mode still is=
n't
>>>> working.
>>>
>>> Host mode musb is working just fine on Overo with the "set
>>> transceiver" patch.  Not sure why you are having trouble with Beagl=
e
>>> (and can't check since I don't have my Beagle board with me at the
>>> moment)
>>
>> I should clarify: OTG mode with a host cable doesn't work in .27rc, =
it does=20
>> work in 2.6.26. I haven't tried specifying pure hostmode, only OTG.
>> I would try it on the evm as well, but that is having serious irq is=
sues=20
>> with .27rc, pressing a key on the keypad triggers an irq overrun, et=
hernet=20
>> gives an oops on boot when trying to register and irq etc,etc. 2.6.2=
7 is=20
>> looking really, really bad on omap3 at the moment.
>
> Yeah, we lost some musb history when it went to mainline. I didn't te=
st
> this patch yet cuz I've been quite busy at work, but it should make
> beagle work. Could you tell me if makes it work ?
>
> diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.=
c
> index 9d2dcb1..f7fe91e 100644
> --- a/drivers/usb/musb/omap2430.c
> +++ b/drivers/usb/musb/omap2430.c
> @@ -215,12 +215,14 @@ void musb_platform_set_mode(struct musb *musb, =
u8 musb_mode)
>
>  int __init musb_platform_init(struct musb *musb)
>  {
> +       struct otg_transceiver *xceiv =3D otg_get_transceiver();
>         u32 l;
>
>  #if defined(CONFIG_ARCH_OMAP2430)
>         omap_cfg_reg(AE5_2430_USB0HS_STP);
>  #endif
>
> +       memcpy(musb->xceiv, xceiv, sizeof(*xceiv));

Does this even compile?  It doesn't match my patch, which is simply a
diff between the original l-o tree and what went upstream, and there
that last line looks like this:

+	musb->xceiv =3D *xceiv;

--=20
M=E5ns Rullg=E5rd
mans@mansr.com

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
