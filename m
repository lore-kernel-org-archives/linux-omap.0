From: =?ISO-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v4 11/18] input: Add initial support for
	TWL6040 vibrator
Date: Thu, 16 Jun 2011 14:13:59 +0300
Message-ID: <5476342.2jZLF0UGcI@barack>
References: <1307706876-4768-1-git-send-email-peter.ujfalusi@ti.com>
	<20110615081858.GM8141@htj.dyndns.org>
	<20110615082301.GN8141@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20110615082301.GN8141@htj.dyndns.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Tejun Heo <tj@kernel.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Samuel Ortiz <sameo@linux.intel.com>, Tony Lindgren <tony@atomide.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "Lopez Cruz, Misael" <misael.lopez@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Girdwood, Liam" <lrg@ti.com>
List-Id: linux-omap@vger.kernel.org

On Wednesday 15 June 2011 10:23:01 Tejun Heo wrote:
> On Wed, Jun 15, 2011 at 10:18:58AM +0200, Tejun Heo wrote:
> > No human being can feel 120usec difference and I can't see how using
> > HIGHPRI is justified here (which is what the code is doing
> > _accidentally_ by using singlethread_workqueue).
> =

> Ooh, one more thing, and even if you insist on using HIGHPRI (please
> don't), you don't need to create workqueue for each device.  You can
> just create one for the whole driver in init and destroy it from exit.
> What matters is the HIGHPRI attribute of the workqueue.  The number of
> workqueues is completely irrelevant.

Fair enough.
I'll move to create_workqueue.
If we later find issues with this (in a 'live' system), we can figure out a =

way to fix it.

Thank you for your time on this.
I'll make the changes accordingly.

Regards,
P=E9ter
