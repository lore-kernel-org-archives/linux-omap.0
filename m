From: Steve Calfee <stevecalfee@gmail.com>
Subject: Re: [PATCH 1/2] OMAP4: HDMI: Add OMAP device for HDMI audio CPU DAI
Date: Tue, 24 May 2011 11:12:22 -0700
Message-ID: <4DDBF506.6090500@gmail.com>
References: <1305602079-3852-1-git-send-email-ricardo.neri@ti.com>	 <1305602079-3852-2-git-send-email-ricardo.neri@ti.com>	 <4DD2CDED.6090605@gmail.com> <201105180841.20224.peter.ujfalusi@ti.com>	 <4DD3FCC2.3020908@gmail.com> <1306208378.1897.302.camel@dexx0075479.dextra-mty.naucm.ext.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:62279 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752799Ab1EXSM0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 May 2011 14:12:26 -0400
Received: by pvg12 with SMTP id 12so3080173pvg.19
        for <linux-omap@vger.kernel.org>; Tue, 24 May 2011 11:12:26 -0700 (PDT)
In-Reply-To: <1306208378.1897.302.camel@dexx0075479.dextra-mty.naucm.ext.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ricardo Neri <ricardo.neri@ti.com>
Cc: "Ujfalusi, Peter" <peter.ujfalusi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "Cousson, Benoit" <b-cousson@ti.com>, "paul@pwsan.com" <paul@pwsan.com>

On 05/23/11 20:39, Ricardo Neri wrote:
> Hi Steve,
>=20
> Le mercredi 18 mai 2011 =C3=A0 12:07 -0500, Steve Calfee a =C3=A9crit=
 :
>> On 05/17/11 22:41, Peter Ujfalusi wrote:
>>> On Tuesday 17 May 2011 22:35:09 Steve Calfee wrote:
>>>> I think the generally accepted method of doing stuff like this is =
to
>>>> have the ifdeffery in a header file where a inline code segment is
>>>> defined if it applies to the processor being built. If the code do=
es not
>>>> apply to the model being built, a null #define is used, which does=
 not
>>>> take any space.
>>>
<SNIP>
>>
>> The preferred header contained ifdeffery does not exclude the
>> possibility of having multiple options selected, even at run time. I=
t
>> also can prevent multi cpu code bloat if it is not wanted.
>> Alternatively, X86 distributions such as Ubuntu already deal with
>> multiple arches (within the base arch intel/amd), using initrd type
>> startups.
>>
>> Also the current "cpu_is" stuff is not very scalable, when TI gets t=
o
>> Omap42, or even slightly smaller such as Omap5, the untidiness of th=
e
>> current technique will become even more of a problem.
>>
>=20
> Thanks for your comments. Even though the use of cpu_is_ may not be t=
he
> best approach, it is used extensively in OMAP code. Do you think that
> this situation needs to be fixed before accepting the patches for the=
se
> two devices?
>

Hi Ricardo,

I am not the omap maintainer, I am not blocking anything.

I have lately been surfing the Omap code on a project. The cpu_is_*
stuff is common and growing. People are fixing it, see the patch for
gpio that was in today's mail.

I know you just want to get your stuff into the tree, not fix the entir=
e
tree from problems you did not cause. However, someday, someone will
have to fix it up.

=46or instance as an example of how to remove #ifdefs --
arch/arm/mach-omap2/clock.h uses ifdeffery in the header to remove it
from the c code. It checks a config option and adds or removes code wit=
h
no source changes.

It is possible to add a config_all_options so run time checks could be
made for the cases when a single executable is desired for multiple
archs. In this case the macro or static inline could wrap the option
selected code with a runtime cpu_is check, all without modifying the .c
source code.

The optimizing compiler is really friendly to conditionally doing stuff=
,
if/else clauses that are never used (constants in conditionals) just
disappears.

Sample header file definitions (not even compile tested, in fact
intentionaly incomplete but based on your patch):

static inline  void __omap_init_hdmi_audio(struct your args) {
	oh_hdmi =3D omap_hwmod_lookup(oh_hdmi_name);
	WARN(!oh_hdmi, "%s: could not find omap_hwmod for %s\n",
			__func__, oh_hdmi_name);

	od_hdmi =3D omap_device_build(dev_hdmi_name, -1, oh_hdmi, NULL, 0,
			NULL, 0, false);
	WARN(IS_ERR(od_hdmi), "%s: could not build omap_device for %s\n",
	__func__, dev_hdmi_name);
}

#ifdef CONFIG_ALL_OPTIONS
static inline  void omap_init_hdmi_audio(struct your args)
{
	if (cpu_is_omap44xx())
		__omap_init_hdmi_audio(struct your args);
}
#else
#ifdef CONFIG_CPU_OMAP44XX
static inline  void omap_init_hdmi_audio(struct your args)
{
	__omap_init_hdmi_audio(struct your args);
}
#else
static inline  void omap_init_hdmi_audio(struct your args) {}
#endif

And then the .c code would just contain:
omap_init_hdmi_audio(struct your args);

> Also, in the case of OMAP, runtime CPU identification is needed, for =
the
> reason Peter mentions. It is hard for me to see how it can be
> implemented using #ifdef only. Do you think that runtime CPU
> identification should be moved to the header containing the ifdeferry=
?

Yes, based on configuration options. An alternative to ifdefs and cpu_i=
s
is like today's omap gpio changes, where data is stuck in some structur=
e
at init time and then used at run time to conditionally init stuff. Thi=
s
can be fairly obscure, but so are macros, and it is caused by the
fundamentally difficult problems of a maze of arches similar, but not
identical.

> Individual functions for different domains (audio, video, etc.) would
> still need to check at runtime if their devices are required. Perhaps
> having a single omap2plus_defconfig for all OMAP2/3/4/x/y/... devices=
 is
> no longer convenient as more and more OMAP families arrive. What do y=
ou
> think?

Such choices that are realistic runtime detected requirements are fine.
In most cases I have seen they are arch specific and board specific, so
really the capabilities should be platform specific and only actually
used on systems that need the capabilities.

>=20
> Regarding using a initrd, that applies only for loadable modules, but
> not for built-in modules, correct?
>=20

Yes, although I think it is possible for an initrd to select another
kernel to load. In any case that is distribution specific and should no=
t
really be required for most omap kernel use. I merely suggested it was =
a
possible alternative to an all-in one kernel build for your specific
multiarch board. It is an alternative so my poor older omap does not
have to carry around code for omap4, just because someone, somewhere
might want it on their board. In general I think the header and
structure solutions are more applicable.

Regards, Steve
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
