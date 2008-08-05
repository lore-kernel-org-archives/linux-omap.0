From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP PM interface, version 3
Date: Tue, 5 Aug 2008 17:18:20 +0300
Message-ID: <20080805141818.GQ7193@atomide.com>
References: <20080717015741.14287.75980.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:56376 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754553AbYHEOS3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Aug 2008 10:18:29 -0400
Content-Disposition: inline
In-Reply-To: <20080717015741.14287.75980.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, jouni.hogander@nokia.com, rnayak@ti.com

* Paul Walmsley <paul@pwsan.com> [080717 05:00]:
>=20
> Hello everyone,
>=20
> this is the third version of the OMAP PM interface patch.
>=20
> Major changes since the second revision:
>=20
> 1. set_max_mpu_wakeup_lat() has been added.  This is intended to limi=
t
>    the amount of time needed for the MPU to wake up and enter a devic=
e
>    driver's interrupt handler.
>=20
> 2. set_max_dma_lat() has been renamed to set_max_sdma_lat()
>=20
> 3. omap_pm_dsp_get_opp_table() and struct omap_opp have been added fo=
r
>    future DSPBridge/CPUFreq use.  omap_pm_if_init() now takes pointer=
s
>    to struct omap_opp arrays that are intended to be passed in from t=
he
>    board-*.c files.
>=20
> 4. Interface documentation has been moved to the=20
>    include/asm-arm/arch-omap/omap-pm.h file.
>=20
> 5. Documentation updated and moved into Documentation/arm/OMAP/omap_p=
m
>=20
>=20
> Further comments welcome,

I think we need to run this by LKML, linux-arm-kernel, and linux-pm
before we integrate these. Can you repost these for comments one
more time so we get comments from other mailing lists?

Thanks,

Tony


>=20
>=20
> - Paul=20
>=20
> ---------------------------------
>=20
> This message proposes the third version of a power management
> interface (the "OMAP PM interface") for the linux-omap kernel tree.
>=20
> It includes a general device driver PM interface, along with some
> specialized interfaces for CPUFreq, DSPBridge, and the
> powerdomain/clockdomain code.  This message focuses on the general
> device driver portion, since it is most relevant to the larger
> community of OMAP device driver developers.
>=20
> The interface is intended to allow drivers to take advantage of OMAP
> power management features:
>=20
> - without locking drivers into a particular underlying implementation=
;
>=20
> - without adding constraints that are specific to particular OMAP
>   variants; and
>=20
> - without affecting other architectures.
>=20
> The device driver portion of the interface covers four types of PM
> constraints:
>=20
> 1. Set the maximum MPU wakeup latency
>=20
> 2. Set the maximum device wakeup latency
>=20
> 3. Set the maximum system DMA transfer start latency (CORE pwrdm)
>=20
> 4. Set the minimum bus throughput needed by a device
>=20
>=20
> These are described in more detail in the patch.
>=20
> This interface is intended to be temporary, to survive only until the
> Linux PM QoS layer supports these features.
>=20
> This interface is a collaborative product of many people from Nokia
> and TI: Karthik Dasu, Jouni H=F6gander, Tony Lindgren, Rajendra Nayak=
,
> Sakari Poussa, Veeramanikandan Raju, Anand Sawant, Igor Stoppa, Paul
> Walmsley, and Richard Woodruff.
>=20
> Included in the patch is a 'no-op' implementation that documents the
> interface and emits debug messages.  Rajendra Nayak at TI has
> developed an initial implementation of the OMAP PM interface that
> relies mostly on TI's Shared Resource Framework.  Also under
> development is an implementation of the OMAP PM code that uses the
> existing Linux PM QoS code.
>=20
>=20
> Comments welcomed,
>=20
> - Paul
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
