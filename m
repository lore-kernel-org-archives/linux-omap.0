From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH/RFC 1/2] Add Dspbridge driver to OMAP GIT kernel
Date: Wed, 18 Jun 2008 12:52:53 +0300
Message-ID: <20080618095252.GB29899@atomide.com>
References: <A8E8DDC23969AE4CB38FFF51016C778202D975BA@dlee10.ent.ti.com> <ECC99C9B-90E9-4D91-9E74-7999D3868D20@student.utwente.nl> <A8E8DDC23969AE4CB38FFF51016C778202D97C48@dlee10.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:50400 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752157AbYFRJwU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Jun 2008 05:52:20 -0400
Content-Disposition: inline
In-Reply-To: <A8E8DDC23969AE4CB38FFF51016C778202D97C48@dlee10.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Cc: Koen Kooi <k.kooi@student.utwente.nl>, linux-omap@vger.kernel.org, "Gupta, Ramesh" <grgupta@ti.com>

Hi,

Some comments on integration below.

* Kanigeri, Hari <h-kanigeri2@ti.com> [080617 19:49]:
> Hi Koen
> > 
> > That still seems to have the OSAL layer. I don't think the linux
> > kernel needs code to support things like symbian and windows mobile.
> >
> 
> --- Thank you for your comments. Can you please elaborate your specific
> concerns on the modules present in OSAL layer. Majority of the code that
> is present in this OSAL layer are not acting as wrappers to the kernel
> calls, and even the functions that are acting as wrappers (eg:
> MEM_Alloc) provides some additional debugging feature that are very
> handy in debugging some critical Bridge issues. Does renaming OSAL to
> some other name address your concern ? 
> 
> Thank you,
> Best regards,
> Hari
> 
> > -----Original Message-----
> > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> > owner@vger.kernel.org] On Behalf Of Koen Kooi
> > Sent: Saturday, June 14, 2008 3:48 AM
> > To: Kanigeri, Hari
> > Subject: Re: [PATCH/RFC 1/2] Add Dspbridge driver to OMAP GIT kernel
> > 
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA1
> > 
> > 
> > Op 14 jun 2008, om 02:01 heeft Kanigeri, Hari het volgende geschreven:
> > 
> > >
> > > This patch adds the dspbridge driver functionality for OMAP3
> platform
> > > to the OMAP GIT kernel. DSP Bridge driver provides features to
> control
> > > and communicate with DSP enabling parallel processing for multimedia
> > > acceleration. It enables the applications running on MCU to offload
> > > the processing to DSP.
> > >
> > > Some of the key features of DSP Bridge are listed below.
> > >
> > > - Messaging: Ability to exchange fixed size control messages with
> DSP.
> > > - Dynamic memory management: Ability to dynamically map files to DSP
> > > address
> > > space.
> > > - Dynamic loading: Ability to dynamically load new nodes on DSP at
> run
> > > time.
> > > - Power Management: Static and dynamic power management for DSP.
> > >
> > > The patch is available at
> > > http://www.omapzoom.org/pub/dspbridge/dspbridge_mpu_driver.patch
> > >
> > > The documents for reference can be accessed from
> > > http://www.omapzoom.org/pub/dspbridge/db_linux_pguide.pdf
> > > http://www.omapzoom.org/pub/dspbridge/db_linux_rguide.pdf
> > > http://www.omapzoom.org/pub/dspbridge/
> > > Linux_Bridge_Integration_3430.pdf
> > >
> > > Please let me know your comments on how we can work to include the
> > > Dspbridge driver source code in OMAP GIT tree.
> > 
> > That still seems to have the OSAL layer. I don't think the linux
> > kernel needs code to support things like symbian and windows mobile.
> > 

Guys, we're trying to do things the standard Linux way. Please break
your giant patch in to logical readable patches and start submitting
them few patches at a time. Nobody's going to read this giant single
patch.

In addition, read the following:

Documentation/CodingStyle
Documentation/SubmittingDrivers
Documentation/SubmittingPatches
Documentation/SubmitChecklist

And then make sure scripts/checkpatch.pl will not produce errors or
obvious warnings. Otherwise this code will just get ignored by people
who should review the patches.

Regards,

Tony


> > regards,
> > 
> > Koen
> > 
> > 
> > 
> > 
> > 
> > >
> > > Please let me know if you need any additional information or
> questions
> > > on dspbridge.
> > >
> > > Thank you,
> > > Best regards,
> > > Hari
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe linux-
> > > omap" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > >
> > 
> > -----BEGIN PGP SIGNATURE-----
> > Version: GnuPG v1.4.5 (Darwin)
> > 
> > iD8DBQFIU4XDMkyGM64RGpERAp1cAKCl1amRWN9D0LbELsk0veON+TR6RwCfUPv8
> > TPiGLJ2+cjlf0tneY0UuPHE=
> > =GFHv
> > -----END PGP SIGNATURE-----
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-omap"
> in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
