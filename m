From: Tejun Heo <tj@kernel.org>
Subject: Re: Re: Re: [alsa-devel] [PATCH v4 11/18] input: Add initial support
 for TWL6040 vibrator
Date: Sat, 18 Jun 2011 17:36:38 +0200
Message-ID: <BANLkTi=GpTiH3oRuEtjE0S-aZ5_V16LDnw@mail.gmail.com>
References: <1307706876-4768-1-git-send-email-peter.ujfalusi@ti.com>
	<5740779.B2nyl9oMW4@barack>
	<20110617094332.GE2611@htj.dyndns.org>
	<1541792.uUz2bSMDMl@barack>
	<20110618145724.GB18190@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <20110618145724.GB18190@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: =?ISO-8859-1?Q?P=E9ter_Ujfalusi?= <peter.ujfalusi@ti.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Samuel Ortiz <sameo@linux.intel.com>, Tony Lindgren <tony@atomide.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "Lopez Cruz, Misael" <misael.lopez@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Girdwood, Liam" <lrg@ti.com>
List-Id: linux-omap@vger.kernel.org

Hello,

2011/6/18 Dmitry Torokhov <dmitry.torokhov@gmail.com>:
> For my education, what is the benefit of creating a dedicated workque=
ue
> with alloc_workqueue (which, as far as I understand, does not end up
> having dedicated worker threads but will use the common pool) and sim=
ply
> queueing the jobs on system-wide workqueue?

In this case, nothing really, but P=E9ter seems to want to have a
dedicated workqueue so that he can later flip HIGHPRI easily if
necessary.  Usually what a separate workqueue buys are...

* It serves as a flushing domain.  ie. You can flush work items queued
to the same workqueue together.  This is useful when individual work
items can't be flushed (e.g. they free themselves) or doing so is
inefficient.

* It serves as an attribute domain.  ie. You can set WQ_* flags and
@max_active.  If using the default values, nothing really is different
from using system_wq.

Thanks.

--=20
tejun
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
