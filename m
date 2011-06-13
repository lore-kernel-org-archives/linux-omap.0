From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v4 11/18] input: Add initial support for
 TWL6040 vibrator
Date: Mon, 13 Jun 2011 14:20:28 -0700
Message-ID: <20110613212028.GA13138@core.coreip.homeip.net>
References: <1307706876-4768-1-git-send-email-peter.ujfalusi@ti.com>
	<1307706876-4768-12-git-send-email-peter.ujfalusi@ti.com>
	<20110611231854.GA3979@core.coreip.homeip.net>
	<1530216.k8lJ4nKZ1s@barack>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <1530216.k8lJ4nKZ1s@barack>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: =?iso-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@ti.com>, Tejun Heo <tj@kernel.org>
Cc: Jorge Eduardo Candelaria <jorge.candelaria@ti.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Samuel Ortiz <sameo@linux.intel.com>, Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "Lopez Cruz, Misael" <misael.lopez@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Girdwood, Liam" <lrg@ti.com>
List-Id: linux-omap@vger.kernel.org

On Mon, Jun 13, 2011 at 12:51:16PM +0300, P=E9ter Ujfalusi wrote:
> On Sunday 12 June 2011 01:18:54 Dmitry Torokhov wrote:
> =

> > > +static int twl6040_vibra_open(struct input_dev *input)
> > > +{
> > > +     struct vibra_info *info =3D input_get_drvdata(input);
> > > +
> > > +     info->workqueue =3D create_singlethread_workqueue("vibra");
> > > +     if (info->workqueue =3D=3D NULL) {
> > > +             dev_err(&input->dev, "couldn't create workqueue\n");
> > > +             return -ENOMEM;
> > > +     }
> > =

> > Why do we need to create a separate workqueue? With arrival of CWQ
> > it looks like we should be able to use one of the system-wide
> > workqueues for this.
> =

> The reason for this is to ensure that we have the lowest latency as possi=
ble =

> in most case. In the embedded devices we use the vibra for tactile type o=
f =

> feedbacks as well, where few tens of ms delay can be felt.

Even if you create a dedicated workqueue with CWQ it will still be using
shared pool of threads so I do not think that latency will be affected
by using system-wide workqueue. I might be mistaken though, Tejun will
correct me if I am wrong...

Thanks.

-- =

Dmitry
