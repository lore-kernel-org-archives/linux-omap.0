From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: Current OMAP build failures
Date: Thu, 6 Jan 2011 17:41:03 +0530
Message-ID: <3b65fe7bf98487ac1db721981f4c8bca@mail.gmail.com>
References: <20110106110336.GC31708@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0023547c8d736d97bd04992c6518
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:38658 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753349Ab1AFMLH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Jan 2011 07:11:07 -0500
Received: by mail-yx0-f172.google.com with SMTP id 33so7197076yxt.31
        for <linux-omap@vger.kernel.org>; Thu, 06 Jan 2011 04:11:06 -0800 (PST)
In-Reply-To: <20110106110336.GC31708@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

--0023547c8d736d97bd04992c6518
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Russell,
> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Russell King - ARM Linux
> Sent: Thursday, January 06, 2011 4:34 PM
> To: Tony Lindgren
> Cc: linux-omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> Subject: Current OMAP build failures
>

Have you used any custom build/ additional build flags
for omap2/3/4 reported issues ?
I just rebased Tony's 'omap-for-linus' branch with 2.6.37 and
it not seems to report below issues. May be it's getting
fixed as part of 2.6.38 omap queue or my build config is
not same as yours. I used omap2plus_defconfig.

> =3D=3D=3D omap2 =3D=3D=3D
> arch/arm/plat-omap/devices.c:253: warning: =E2=94=82omap_init_wdt=E2=94=
=82 defined
> but not used
> arch/arm/mach-omap2/irq.c:64: warning: =E2=94=82intc_context=E2=94=82 def=
ined but
> not used
> arch/arm/mach-omap2/prcm.c:122: warning: =E2=94=82prcm_context=E2=94=82 d=
efined but
> not used
>
> Missing __maybe_unused or something else?
These seems to be fixed in omap queue.
>
> It also comes with three section mismatches:
>
> WARNING: vmlinux.o(.text+0x1f4c4): Section mismatch in reference
> from the function omap_early_device_register() to the function
> .init.text:early_platform_add_devices()
> The function omap_early_device_register() references
> the function __init early_platform_add_devices().
> This is often because omap_early_device_register lacks a __init
> annotation or the annotation of early_platform_add_devices is wrong.
>
> As early_platform_add_devices() is marked __init, so too should be
> omap_early_device_register().
I don't see this one. May be fixed
>
> WARNING: vmlinux.o(.text+0x1f6bc): Section mismatch in reference
> from the function omap_device_build_ss() to the function
> .init.text:early_platform_add_devices()
> The function omap_device_build_ss() references
> the function __init early_platform_add_devices().
> This is often because omap_device_build_ss lacks a __init
> annotation or the annotation of early_platform_add_devices is wrong.
>
> This looks like omap_early_device_register() has been inlined into
> omap_device_build_ss(), and it doesn't look like it can be marked
> __init.
>
> Rather than passing an 'is_early_device' into this function, split
> out the common code into a separate function which takes a function
> pointer to the registration function.  Then you can have two
> additional
> functions, one marked __init which uses omap_early_device_register()
> and one not marked __init using omap_device_register().
>
> This also means that we get the init-section type checking further
> up
> the chain.
This too
>
> WARNING: vmlinux.o(.data+0x6bd4): Section mismatch in reference from
> the variable h4_config to the (unknown reference)
> .init.data:(unknown)
> The variable h4_config references
> the (unknown reference) __initdata (unknown)
> If the reference is valid then annotate the
> variable with __init* or __refdata (see linux/init.h) or name the
> variable:
> *_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console,
>
> Maybe it shouldn't be marked __initdata?
This too
>
> =3D=3D=3D omap3 =3D=3D=3D
> WARNING: vmlinux.o(.text+0x1b780): Section mismatch in reference
> from the function sdp3430_twl_gpio_setup() to the function
> .init.text:omap2_hsmmc_init()
> The function sdp3430_twl_gpio_setup() references
> the function __init omap2_hsmmc_init().
> This is often because sdp3430_twl_gpio_setup lacks a __init
> annotation or the annotation of omap2_hsmmc_init is wrong.
>
> Missing __init on sdp3430_twl_gpio_setup ?
This too
>
> WARNING: vmlinux.o(.text+0x1f714): Section mismatch in reference
> from the function omap_early_device_register() to the function
> .init.text:early_platform_add_devices()
> The function omap_early_device_register() references
> the function __init early_platform_add_devices().
> This is often because omap_early_device_register lacks a __init
> annotation or the annotation of early_platform_add_devices is wrong.
>
> As before.
This too
>
> WARNING: vmlinux.o(.text+0x1f90c): Section mismatch in reference
> from the function omap_device_build_ss() to the function
> .init.text:early_platform_add_devices()
> The function omap_device_build_ss() references
> the function __init early_platform_add_devices().
> This is often because omap_device_build_ss lacks a __init
> annotation or the annotation of early_platform_add_devices is wrong.
>
> As before.
This too
>
> WARNING: vmlinux.o(.data+0x20670): Section mismatch in reference
> from the variable twl_driver to the function .init.text:twl_probe()
> The variable twl_driver references
> the function __init twl_probe()
> If the reference is valid then annotate the
> variable with __init* or __refdata (see linux/init.h) or name the
> variable:
> *_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console,
>
> twl_probe shouldn't be __init ?
>
I only see the twl_probe section miss-match. Have attached full build
log for reference.

Regards,
Santosh

--0023547c8d736d97bd04992c6518
Content-Type: application/octet-stream; name="2.6.37_omap_for_linus.tar.bz2"
Content-Disposition: attachment; filename="2.6.37_omap_for_linus.tar.bz2"
Content-Transfer-Encoding: base64
X-Attachment-Id: 10b04ac870c27f7a_0.1

QlpoOTFBWSZTWUDWWisAIQD/pPAQBABY///yP//euv////AAQAAIAAhgKd4HgCk0T72KgUAUqM2t
5trodDras3uffd2+g417gHej1SxWvn3OoE7aS83Ht7va50d2M8mF0jZlYwczVC67c5NhDbu3YbaM
VBFbKHnbhNELl615B5C2NVMNBAIYTQhM0mmpAjTQwNAMgAGkxMNT0JiBBBDSaJPUAAABoAAAACU0
0UKYIQaNNANAaMgANAAAAAk1IIJoE00mqbTTQmRDT1AGgNAGg9QACJIkwgIxT0KaempPUeUNMmah
6m0hiMjZTNTaR6gkRBACAmKZEmSem1TIGnqMg0AAAB3fhx99oGOCJ00dR2dnZe+opiyooKifnH2H
oD/dC/dEkF4wT8YIn4QAkAFGRBV68Cge+Ii/ZEFW0AMK6/abbYO7h1cf8mAo5wF0gyCA1DXDh+dV
WzZ+t2+SR17s/ju08oYyEk3VUz6nN6dFFUTysDpABVE9Ll6v5/Q/R6I97Tq9FpLFJJTFSH00q2iq
kbCSINNJKSCowBpqmSUkiwQVJFkikFYixGKMYiIogsWKKKLFBIyIoiwWAoiRQEYKsUiwUEZFgiKR
YsFAUBRRRYCgIigCKqCKyIxYqkWCokWCMEQiogiIyKsBVkFFBRSCiyKEWAKCwiyRSAisRBSLIsgs
BQUUIoCgRYiRRYRVZBAkVZFZEGRELQqEIKSKMFFgQRAiiMWEgioKIyIwFiyLCKIxYCiwiFz+Pbxb
5G2AoiHviqDUXCHptnnD2GTmQkYTwefIQu5c/4enzy5n391hT1+ahARD2zUnup80UABdT85ixi/s
oUC0Rpi5dy7k5S+xOTnsZ+8gTPXu0RS7yGyUOxuNB/GPCBQ4O59L+xzbupwdDemBoYBsfxd7Zu5j
8mja4/M0NGczsUNmIfbsEpsbE6s7/lhD4LdJWKlDraDX6h0fafFvdSvnIywKQJhZEhTIy+nz9pgu
kHZZm0fBi+nB/qknlESZsic2T5miXcIBnqkhp2XXNBuYyIAAAzeNGf+cMJtg9mEdh5Wpa24OqQek
gAolN4/VbXS2EW6fr2m7WUOUKWtlmVPT6SOMOL16Stp34RUKJwndd6H9YAp8oAL3B7ZHBNISFsj5
5IFQLu4dy2CCg67oF0K/kXIcPEfxIRht3ND9Zk8+pwo1KCKMae5+RvgZ14Mi0vLDsmEe7kUW7haW
70DWvTtTE3Qotd5mjxI5M7UYp2Op5MB5IZt0+BXPMvX1d20FhvbewFquoQoicKLEqEJghDHZM5Mx
XxN55+B3wnPnsOLMzz8Nk5I8RM7dNHrYncmQbV89vJUz3zF71T/mMXGvFx1t3PjuMxwVn11nEr7G
pfgj02RtrdIlcUfHdemG29Ouj75UiTCpdZ3quAQh6m6uV5PCrUMgrdSDXBdYIu+H7CvQKi1mEuQL
B79ubv4vpUvbVYUtmEZkHbz4rrBTdE1ZDPUbelT7cb5rYmajd+xq+/K77Vfub2iOnSbzaN9nyZ4a
zJjjbjsrio7pqN3VO9+gU7anV6XIJcxcjNS6Oj0Lt4/dBRF5QxvVm9BFY8eMWMpTJYWWSojTskBx
SKxOMGoceTVru7HTBI9ZeapZBGnZqLZLHayOEVar0LtcaJZZq2FZ9969669oscaSXx8Vs6QuQYPS
0Pe7EuyoFCWGzMu9QjQZEhPgqi55UlAYO6WrOx9+9Tzc8LMVmZZj8ioonlbU6uoJDjZ+V072QdNp
K4ruEs4J3xD3mZdAvpVKZW8PGLaGDxl4fPtLV6h4BLHydAQqaTePG7PwqblrlhlGOccJVvbd5aeW
qu10fnoqR2humJ60ZV2VzzZ4bymvhqwcpVriy2r5zGq+TCr+ITXOWbhK5NoWF4qUU0Pj083h+eEt
hwVPLbevEZkcYuCterK3Zo885lgV6pNbS6FOcV3V7ssH32wGBmYcbcMJ3XG6T6I1aI5FSS0qbWZ0
F80bCWJJYcQyrbeNZe8wMRlxs2uWod8BrFMEVPpwV1fqnHI5soVlxzncJhmlYdz7pGrIYqko3Gso
ojhWVbkx0azc7BBtxZtOu9pnHEJS0+a4YueICC2jk0mxgokyyJxv7mAYsgjDKzkn2ryYbhNuyZom
NHz0LKKOZBGca4thydDNjQFM8+XerXEmTsFzc0uOLrtdj4rvqjYOwwy13gLmTzM93JOm7EVND6O7
HSfMRias4K102hVcnS6q0NLEvL3fSZmYDPToAPYAAkOcS6r1nkyttoWrsz1tM+fIAAbZ60+VE4vh
UhpJv1xnroi1PF5SFi0Y0k3Qr0zsGAAZCU6XrZvxeumHv09YXee2asiD37TyhzHkrKnCjk4i4fnk
1mbPOCvxjf5LAW0hRTZI4aGmNkLLXW62Op3NlNsV2Y2tKcaBHatGT3dFHypHmcd33mpsS4yOmaOr
oadJags0DCU4ZBQYfVwKdMMCu2wilyOrErjKXrPRRhN78dmb3Vkca95Ne/K8HBJg776862NCrb9K
1qmlKiqglJQ1KhQygEKB6acO2c8QYcOaJRnvUJ0tZ2rQIMHFq0qiB4TF0cA9LR5XR6DkYo87u2ku
y4MHile/OD0B5vN9o069OvVusG8a8t1LeiMmKkPRAH0vxWmAjRttNoIYx4lF998Xshm8XZ5QbxFG
GjE4rd9Mq3R4tYnCGg7aZ8Fe8LKVLMIKFokzIDK9aUc2AJ5AWcriu/BqCoEaSME77wKNOkTeasWS
NeicaPpgscpnNlXyFRQkLSpfTeuXSuboaYxEabCzHokkZYMFZ84jnkBVoAxc3qa3zQA5tVJt7gpo
9IIT6WJHMMusSMML5KmNrJLAZWyDfKinBDDIEAYYJ1Ea2xrDc4ZgJtsRmxrQCMS9ZbcxshcClLNQ
CvBOTKCyqbFouLoFjFA8MRzMk2kQhgYGxs0bPnbEZcFooQjSDnxZA1VCRs03ZpYnPPXKoKIwewK+
0VnPU45Kl6wkw8WAwzrmwzKAUY02EA7bGBXm1V6lZWtJpSdrib8GMSBuZ05HhDXRHI0UI1KKU5y4
CybGEprO+HONWAmsMZjHKzJNdZ9roZeEYRcyUGqjRRrLSgtntIFWkbbYIsRQigh84VumkbbkZ27S
jfbWQE8MhYRk03DvnXba2GFb4BTCPsr3cIgaGpZGMIGSMTQMqcdWUguSlQKQnHPG8kB0v3aO2cKW
ai9JnOB2p3DRtTW1OXbObAcYWQctMroYA1nFpWFRqMzIiwA0hvVkWskGYq2eTMX1eRzhCwBLUzja
yIl51sCSeUECCCKAAkUoQl6Dv0m8OvKK0POZp0zWB1ZjzirfOO7drzyQl+3JYG3jZyI31BnOMIib
83MDvJwBcscdmCyfV8z7pl+BOVV6tn83d0xmS0/X9v/SWLz3/W0bP5uNPFzV4asZZZOUcGGtZviz
bAkrktB8IezUm2pxnez3suIvRyScG+0WFMJ7T3mrG8+E3yEBxSOgZf92FUnH4CYYPMI4vv//bz7/
k7Sx4ztplABUqqFYkJKqiURoClWqRAqiiAMYrSNEpYePjqzOb+vP2esoKw1ZN+XUWx4ie75Adu4J
4MEefc6bz9c2DUzA069qUbANkqoZzhXx5+oO/fa2vPRUpjafrm6e5sbY01WCC5sMHJaEhhjEbDm3
2/Y74bjgjVIiIcJkTQEMFyxSVo6Z6g+Sf55ajXbHq2sCJ8z5mVrGZmcUIBGxCrr5f7D7g8ciikCQ
MNHkXbcO4gGWJt47jLGTsI27Zi7XhzwYR6iNYK2SdUzQuVxAf9EtBMQPTpMeanTmKDswXFDCDyXR
C+ETMk6GNf9EBSRD4C/jqPcHqB5DYxWvX4uOw80Duj1PjPp+qFPuYCV5+otgAoIQUQQ9TA/I+n/H
rEAftyb9MPvptq+P1vt1h7NwUHuwfz93y62e/05XJV73unsJqDpQ74gA+LnwsZet+7/vEqrqVRT/
oMxM+p42DDU7Uxp5MixLD+IGkE7mCdzYeforrT8jk+u7TuME+H5/j8voPr9QVJY+rWhhff8fCoPL
5tFb+OK+OkaMNbxass+E+03rzcOrIrZzt6MxqYenJrPrc6pe890cHfoUqsrm7FuLxsWPnlYT+QGA
ZGDMglarwuCe1UtdLZnCGaqGAsZshk/87AWf+a3mUp0Z8oOv1KABlo/jFeWBFOuMAB5gUVbm8ehv
DTHO66haiLsX+hgJFbU+D2eGT1AEKswxcc4kY5P0myWdJegClOuMH8NOlLHsXO5a+H43hwmc50Ap
tnqfPJPRu0uxSGt6aOQaazzyzwu58Hui+4KZR0Qk2iyWKZcAF6l4oCbt0GFKVy58jpYsXDF9VHka
swTWKsnHJC41VwZwswMjmzgydiyVCxo2UHdOQnJzYPc1SEKC6aSnWWR2Ei4n43phm7PLv9H/BYOG
mq4b0BFD04kbYO//fbkH3ZXPocqmKCgMQ/b5Ohj3oqIKSS4QA7gJt01RZmIFpPpj+1B8zXA+BPGC
R3slG6Hk6bayp4aNeCojRTrHxtnLBNGUFlj1xETnAqfkIdz8n36bRBQmZgXZxjzyH99sVS6WRpUO
KN64unySw4Cd4P8d4fXBLKc4fZi9cNepE2Sc8MRqTvdtgx6oIbNHN0zhIEiWlBEeLvlpyqsNs9hG
xjsfutnzhQQU+UgjUUaIKEICjIL41A4fJttMjHGOXgFuunOiAAOZYFBNz00c8PGJ5XZoS+ewS1n3
wcHtYXPzFqwkGvR2wRcRWJ43+UQcs3iGLfFkoqmsobbAEXfNLF+7Vbc9qOSA5DBj7zDK1P672x8K
KQBTnxvJmlQ+siexRvQe9sN9MFn87SCIgjIDIDBIRgKMAQiKKSYAre0Ay9+WlENiGUO7c0CwzrMd
NK6e8TvHtQPLx19V3beFvEhBHjIgoZPYtiEwxQ9L5JLYKH1y+aFRtobHwZm0gB5+qOvxQSoyOSjQ
rweTl9Rx8Nfl77ywvkkZAApEZxM2+H4ffd91p8lKEeEYoPQDa+YlQ0t8azBgcNNY6QGgpSSh8j8w
0Eu9SrOatZQlUYfAyskXsEB1CkUAN2FdU1ZYrguaYAocxUNqhAgRCJIQSMQ3WHENcboyzixifmEt
azp53mtHOlq6WzcVdYp1CrOtI0admjGUrQUoXWFsTL49PTX6HftiGxNDoqRfQQhhCXl4Udz2dA6+
ZgIAJu8gAA5k436NB8rrBKVcFC95AqcvSnLpvhwHWFCOGoLFkIIkgxEUjVVCqAzkQRQSCMPaigDu
Qryd/PbJY81MvDPX6edbnQxotqRUpiDixRCrY4sWSrybeEPO99XUSMSAq64tY6G9JG96tWm9XupW
1oSSnU82QEOznB1VlmQ0TtINvqACob9x676SAPuDnnPh5qawBDy+ZswUYdmgkXtjPLh1SDpHOmnI
0Lpakq8i7jgCTs4SbENpWs4gnfxc39r2133yO22WG66cFb8X+Eq01CDSV5uzI1Xai1L6Ow8RBBhB
I3d3fAaomBrEy6zXOpHJgp1HGS+sDVkZGCYMaEEWsKlwo7oWCLliPYnAMQtMuVmzNudaXd59E8hD
2PH1OduPT1D8Kp1zgpagfp7EDMBC58l4aUlmmwl84veJFSjxJA9Srfo1+np8bUyHfFyMlqHDSnTR
GAWP0eaeDy0Yo92Hu0YN29dIwXyrZDrCF4TXwsBacO7Iab8U2WGEas75djDp8C33w596V2iT46ky
fXJJZkAFABoCCp5yApGCgUaeLSufPDf1czgl3hOvJPifEwJ2sG9mzueWDsDa4jd+IcELPPC6UrhQ
rq83q8m6yqzGGUPHKfa0FrRNMHdns1i6ZKCQgJJmXmwDH6KJlEDIr+L5q8Xx29nVw6TwVtwlYJQj
eWXjYJfSQUukBTBF41eGAQZEozI7QtyFTe2WqtqKLmDg6lHVZooAgG7obMJHWnAqscGrKbSmZVwg
mMVJSakhDFISKDBJhVFbyXiK0IBsVLXRa1sGlLLkssgOaM1WBNAuxS2QjlxQqupkwztM8Te02sEA
NRsu0JqhAeBdBUPah5SgU0kjYTDuxLcdC2QvIkOVVnlsM9HVaJLOU82k+dvwXRga+pKk3ONt7GXR
uLMxZRVNS9uQbVOupDjyq0FxU1QqoD35Jr7arQyqoqocp3ZXNPtkO52Zyr454UNSBg8OGNuJi8FU
8IuvXPpBmt0GiDS2GOV0BZxFN/CoMVgiFqkgh3OIxm/jVEpalLAdmTf54TkB7xyz1IUCTJ55Hphz
FUmFtJONIzUzDhQoBpDmilWzOeqWhUCqCsmFzAC6BooUf47AkgY7meV9u2O+hngkhJFGe/NT3PFn
SWdXD7b5VtrHbCcDcxLdusAZAhlFFk1BKtQHPpO9Z0Nx+HrR0SlSzUFUoIAJeqZFdmUaAtcNE0TH
auuUYZ45XtMsLwWSPv/DGQNtNckac8/lrDNfZXUiSaaogDl+peq5fZ0jlTvhcp8HDGONNq+iRJZH
TO8ygyV0mgtprpCWv2CAoeVZU2ZjPLEPukRnX6WzICitlewCc2Pl1VRBgq2ul+14cI3DRyV8/AFw
faESh7YLH1gTqDejTzIM/Nvao3FEzsTsdELUEp27d2wSopkWgpQrtsRuiiCDBO7wolCqk7tzV2kQ
QWAMKvYVZAGAxYBaqIsJLoUlgRSVTe1MCwMhL2pT4EAqE1aOW1KPXshz+k5ICs5gJo9QyPdl6Uy2
yc2bK3KyqcyRuUib4o8DypMh185CXu1i0gqIrxAxjZqfQUk1yFVInXR1xVfeSOzCuzA0xGwVR2Lw
owwxzPTErNgSI57+xr9RUYdVjKBCAFpFVLFJQAAdS9WgCil6M+MoSxr3Xpvp4X2zfg6I/1YNLfPO
ysu6wU6UXz80nyVUVYWkLk6dHXBK7MxG2R3tNJHHGK1qTJGVA2TVD01rrPTtpdxVFKtMoAqkyB+C
64yomFW5dgZgwgG0DI6KI4kAkW/CTpTt20Wjtx7TKJhoGkLp0S039tCzFUJc454w0nDh4bG5vBaA
afEbjpvnDRnq1F+MUbkmKaEEsMzaaoACgi1pCGnxgfR0BVAWQBQDZkFChgRQCmBRm34w/+Tppj7Z
yNzutVv587SKgPDzvw14HR6+L0LIQ5vPHYOQzvfBS2Qwvv4C6awwHDfS1F6SgijiOs8l5Il3IM3+
5EbbrfO969PGOXGcutOFjrKSmhxjAMMJ2ndQJ46CiRi6rscq850KHipHM8gajCoOkgZlkkjQDyxh
4PJQ22LxKSfPMXpLWvsaNBYaw8OiJ7gUBMgPy959qVSXyrFOZ0V2oVEtOFYke3K+DbQFdf0MkQkk
eW4dBD6v9u8npzgcDJA4uIgIw+mtH9y9BuKxOJRXWrDSZZhhhFGIAsWSezLtnbkRNMaTBARm/p9l
X2+nYVWCoyKrGQEYoiEFWDEiKrFiqIwAVQdA0d7KiKTt4qyxhLmxavdkvB0Ru4187AY7BSVD5CbI
FJOnGdoltKULNT2DdfGqgm8MqhJIlTc4mVsdLALsqzJmSeQla1CEm0CTYANgktpLgSVqSKSQgXPZ
8Yin4SRIIZp7iOuVBZGiw4NZwOCu+M8QOJQZPleqtJZn5L2xekbVAsrFYDBGUoFZT/XeWaRF4cWJ
ZAQ+GGqVjO70+j+PIGWRQkUhBLkugUGjn01Lz12JW/YPHsuzgbDPWUelMKVceOnm1OhQ6GqWxRCg
ahxAlG6qPOtu9KlE2lDAujHr7JSZLiFy1HrVAqJExgIJBzWZj88CM8YMuUaMZvXJJpbygAHhAjMR
4OMyai5Wqs9mgqEvSPJO2Im3xL3zpi+bXr60yzw1idfhpk2hGOzUYlItAhIoAQYAxCA1VKRYoQaS
FSIIHi9a4trer1Apy4bpeqmknOEANSN4gxiXMiA3p11q6RZE6Ny6rRt6HKMVpw4EKCWiBNWZtNMu
uuTz8f7YOGnIMpFHEjkZh4g5B3DRIGVIKBKIj3p08lEe/yNsADm1kFoYiEinXHKKlWVpp3oSxtHR
TwGUd0eANNOb8xUiqKxiAqhFYgIxRnt5pQk6wg5cuI/Z88FiWhQVPdU6Q+FUVmImAiAgYxp15yZz
DIIAax59uyU0cKu0tGAMBTGBBw+RNI7DlgYq02OGS3n4UqD3b042ym+AVzOENQcF3xTg/CNPQSQE
VVGKB4YBhAWWxQFKiwFlmlYoKWSw2SLI1UCzJZVYKKAoKSqBZCjh1haF2OSpTydOuVfec/GhP5G2
3FqVIgqp55p3YnM75gYIUKoR3BVWbFogWlRC1F24SdyzLfaKqGrBDAoArA13Oyrd0xpFkUGgikGM
IKkWIzC8ZVVSE1zKzeqayCCFKDExhI2lEU1wMNVrg6xwVCCRXGICEuWCVLKKr0wVh71mMdlMMfI7
k3iAIGMIG8CG8KJf1ZN8YCFTOS3ShaaX68twMmKHQmxkkiHhTMsMcInH1uDJ5DhGfzaCGGYuD4Cg
onFI7eOmRYhh5fHYJDnxoteihXGKlE0gjixV7hRIwGLJam1kNTQGSMKDHJ0klSRAVWCgJ3/Dpp4A
RVAnkI4xskAhEQiusYIskYyZFxO8A6HBWpCpTFxOwgDkmRtYDj2j+rp4bdltMaZoibc0MrDqDU6x
kB7Exm0EhEAkEBj5aGpauMWRLzabFBwFOHZlLYqlBYl2kAsJ1bWaKXWed9gGgKtkQhHsns1D6vma
ZLLQ1N8liJcVZOEY4aXwsNrUA711Ycr32h4Di6uNK8N1I6lfLFQNCv3DM9gxGp6ZL42xVlzeg2Gv
JfEwhQB0XI3UJCpJXQuoJ33zN1yGFVNT85vUR8W5Ip4xPbToAF8r/Q6vmwmdeaHvj87qWWpCIucX
6ZWlATjrxcx45VY5XoBZBhuUSAGBILo1tpe6i8hkaLyXq9ysmLN7pKjoCfscw8ex+UGtKJ9356L3
rjta0Tp3hDqiRiMBRaGxxSJ5LhcOmrlCjnhvdLE1fsP2w6TroKdKeGTkXBAqdZ5PS4ewGOiEMxL4
YU+NUPTFV4eLFkjQj4webLLE6PONYx4tt9WX0Wg9mJKfq0ZHZaIqZdJSCmRWt4FCRG8A1IZTv39p
8WhlnEwCWjWLaSH41g0y5Ky3d2jfEXs9zrmTe7wwk8JILE/aXYxTtqHgiBb/AbNttttIV0AumlWt
/AH0ygF6cMg73mJTp4jcy9QBn14JRNGQpDuy6WjHtR1VX41VjaWtRRUWBZsmPWpYXW5YOrtaliCo
I0CIyCyo4dG7dvtKhgq/W01ZAOLwncuYZXL9MG22x5kcAygc3j8/EJVNjjmBlTHNdFQyYAADvNjr
qXIByej0SGQO5TCSEiHXEVrE4Rk8HMy+u7kbrrGcuva5ob/FPdZJcsw4Mr8kHu7h5TMhPsGghjQa
krd3R1qwUAUaB+qx2sFWwa7wdQPYUpBmIqmOj1PWZWLRHr1UoK0BoReUcIm297LAySkQCKnbGwKn
tgAghgLTJD7461PHWF5CsZ+gES3V8tOQs2gIuNJCSGxcsbUa/I1JJFsACce1ZVC1dydspzwqc18V
CplaYnukg+8gNkHAwgtso63sV61bt717fM9Wy53icmEiQsQtbIGwtQaHKe2meJwPVMaPerVPQj1i
H8JS20VDrXOciH2tC83UtG1V9VcK46361iIF5z3mr7dE1d3Dt6UpV7zBW9pfxz21mB6yEYMZ3tSu
7bwqY5RgUCMFIE2wpKohoUsEBekURNSFKYwbLqpRoVNTBSlQsNONhEpiJERyYjQETCNBKgDILSyj
GwliKEIkIkWoFoDZQgrEBqqVSzTrDOhAkxbFNMSxr2mq+WdMyzqROMiLQ9YqxdcCLbCPDEAVuwye
zEzIt5ZLCw/Lhoo36H+Px9WFUgMUlWEjFfpCpznusnMooUIpBiL2098nKAZJ3Af+F3VT7G8I6txZ
emqdmCxK/P14LW6iDqvp0zGlXm1t3INVWogJbXu6cBwz0XeMKx+EHhcU+Rz0Jo0370LTqqbTLdIL
Mj0CNBbUt6p58EB1zLrBeTryhVcp8+9XzjWx06+/BPXcKh8xgolVVMhQKMBganPArhB+i2Gcy9pj
PLhPu0ve4/H8tSyLfnN9zHZkmeONZ6XxSQh0SWiAIw9dfsvEl69K463tww1tKRWTVp83vdLoNvu9
+BfJbcisIADlXdIKGBK6y6UtXn6rbF1RS2FTpZPE4dtXFRj3Ou1UzkoOwqqahGrFTJUFjDnE7V9e
iV2i12WpQ2Wu711RMAkJKEKEDIo7FacuWavXDiNFwQbOrIvBXLKKO6UlUCdICkKMWJY1LioiIEi5
BstWnQ0BMOAxECq1aoQkIZcgFNy8EoVB77Ar9kQgBUJcWytIQMU3ii6YBeiDJgOypCtYhkrydqIW
wGnZnwb8swjtgtKLDvCMgaDj235AGKhuOKF+pQbCXYs5UgSFGedkIaM12rZaIQ6SdnZt05bEx1zv
Y3A37Xc5OThETkvyMBSmLPxpSemCUB51zSFmij6RS9pEHfJQ+1cqUaKmM9fIkcllGMYrmpWhawEM
QZm6U3N9+gjG6fNGgkFjaNNvGWPFQ3bbBiohR71N+NICTBGSWfXVw6oS6D5sqyNZwde/WXbK5xpt
OeFBUrWTVhEkukCKLTo8rFpgDAxQKsVFrctVAeIH4y/njpssppkiKSHrt5ti/tSNNM5DT3m+mCTK
EnbyZGVkn5CHnJ3sin3wK1EUaF1tpKQAOx9BGR80e3sO3G9Q+rg40/L6SDNHoXNVbF3wQImqMGFi
3CCL9aladsRG9a4xDJqkGCJI5dBsvSOeAu7SEsGgzVkDE/nvRj9jb7c1+/raTgyYkGETquj4AWnj
GrL6Q9LGr6BtEWRFFRPj6wLNMeXOAPwBaN629nNDwY4c3ZEK6+FA5oWS1ICp8WW7obQJc4wS2oJB
CnUhSdzUqpCjYHKDo0j3jPOKAqFGEWfeOSjY/+WiDS4Xe8mOQAUWoA0ZmC9KWhFkF5Z3cGI9T5h1
1f4pY+4D+JhKq2AZQlgYxH8fwqkn6NoltYWeHtfGgJ4QSMbzFrn+b60MhZwAoHZ8yRENcor/slIK
KJFVVgobbRRIhLhsPb3Wu4mP7CH3Pl9Nj7SLTI7y3GvmlOPmWgtritW+mSndzku2LFSFBL00VRQs
lMC7pe9g+3SsXzDkPR+UkGaafpeJIF8CiSKofMT78ej2gapxO24u9Td5H5l/+LuSKcKEggay0Vg=
--0023547c8d736d97bd04992c6518--
