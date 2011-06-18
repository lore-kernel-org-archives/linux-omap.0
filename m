From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v4 11/18] input: Add initial support for
 TWL6040 vibrator
Date: Sat, 18 Jun 2011 07:57:25 -0700
Message-ID: <20110618145724.GB18190@core.coreip.homeip.net>
References: <1307706876-4768-1-git-send-email-peter.ujfalusi@ti.com>
	<5740779.B2nyl9oMW4@barack> <20110617094332.GE2611@htj.dyndns.org>
	<1541792.uUz2bSMDMl@barack>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <1541792.uUz2bSMDMl@barack>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: =?iso-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Samuel Ortiz <sameo@linux.intel.com>, Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Tejun Heo <tj@kernel.org>, "Lopez Cruz, Misael" <misael.lopez@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Girdwood, Liam" <lrg@ti.com>
List-Id: linux-omap@vger.kernel.org

On Fri, Jun 17, 2011 at 01:59:47PM +0300, P=E9ter Ujfalusi wrote:
> On Friday 17 June 2011 11:43:32 Tejun Heo wrote:
> > Just use the default params
> > =

> > 	alloc_workqueue("twl6040-vibra", 0, 0);
> > =

> > Thanks.
> =

> I'll do this for the next posting
> =


Tejun,

For my education, what is the benefit of creating a dedicated workqueue
with alloc_workqueue (which, as far as I understand, does not end up
having dedicated worker threads but will use the common pool) and simply
queueing the jobs on system-wide workqueue?

Thanks.

-- =

Dmitry
