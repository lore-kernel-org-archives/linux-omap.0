From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: [RFC][PATCH] Add support for hook switch on ams-delta
Date: Fri, 5 Jun 2009 00:07:11 +0200
Message-ID: <200906050007.12019.jkrzyszt@tis.icnet.pl>
References: <200905262057.21890.jkrzyszt@tis.icnet.pl> <200906031103.21758.jkrzyszt@tis.icnet.pl> <20090604181833.GG31770@earth.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <20090604181833.GG31770@earth.li>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
To: Jonathan McDowell <noodles@earth.li>
Cc: linux-omap@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

Thursday 04 June 2009 20:18:33 Jonathan McDowell napisa=C5=82(a):
> On Wed, Jun 03, 2009 at 11:03:20AM +0200, Janusz Krzysztofik wrote:
> > Wednesday 03 June 2009 00:04:33 Jonathan McDowell napisa=C5=82(a):
> >
> > > * We assume the bootloader does the appropriate GPIO pin setup fo=
r us,
> > >   so I don't think your omap_cfg_reg is required but it doesn't h=
urt in
> > >   the unlikely event we ever replace the Amstrad PBL.
> >
> > OK, let it stay there. Do you see a need for replaceing it with a n=
ew
> > ams_delta_hook_switch_init() function call that just calls
> > omap_cfg_reg()?
>
> I don't see a need for this; it's always present and not a lot of cod=
e
> to have in the init function as it stands.

=46ine, I'll only add a comment explainig the purpose of the call then.

> > >   Does the input layer not provide a way to obtain the
> > >   state of the switch?
> >
> > Yes, it does, with EVIOCGSW ioctl()[1]. I personally don't like thi=
s way
> > of getting the switch status and would rather see it available over
> > sysfs. However, input guys may have their own preferences and gpio-=
keys
> > driver belongs to them.
>
> I think that's a discussion to have with the input guys rather than
> putting a hack in the platform file then.

Sure. I have a patch for gpio-keys.c ready to submit, let's see how far=
 we can=20
get with the idea of exporting a gpio-keys driven switch state over gpi=
olib=20
sysfs.

> So really the only issue with the patch that remains is if it justifi=
es
> adding a new SW_PHONE_HOOK switch type?

I've just submitted a patch that adds new symbol definition to=20
include/linux/input.h. Do I have to wait for acknowledgement before I=20
resubmit my modified patch that depends on that, or can I submit it now=
?

Thanks,
Janusz
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
