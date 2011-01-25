From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 01/32] arm/omap: use system_wq in mailbox
Date: Tue, 25 Jan 2011 16:37:07 +0100
Message-ID: <20110125153707.GE27510@htj.dyndns.org>
References: <1294062595-30097-1-git-send-email-tj@kernel.org>
 <1294062595-30097-2-git-send-email-tj@kernel.org>
 <AANLkTimMK2Ec8SQiRyRBR+MdVKhAmMaaf+oa0VK3wWsf@mail.gmail.com>
 <20110104052421.GD6748@mtj.dyndns.org>
 <20110125134722.GZ27510@htj.dyndns.org>
 <AANLkTi=Z_ykZptzgi7kt3g21sebEV+hGN72iRcBDC1oC@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <AANLkTi=Z_ykZptzgi7kt3g21sebEV+hGN72iRcBDC1oC@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hari Kanigeri <hari.kanigeri@gmail.com>
Cc: linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue, Jan 25, 2011 at 07:34:08AM -0800, Hari Kanigeri wrote:
> Tejun,
>=20
> On Tue, Jan 25, 2011 at 5:47 AM, Tejun Heo <tj@kernel.org> wrote:
> > On Tue, Jan 04, 2011 at 06:24:21AM +0100, Tejun Heo wrote:
> >> Using dedicated workqueue or system_wq doesn't make any difference=
 in
> >> terms of execution latency anymore. =A0Sleeping work items no long=
er
> >> delay execution of other work items. =A0If mailbox is very latency
> >> sensitive, it might make sense to create a HIGHPRI workqueue but t=
hat
> >> usually isn't necessary.
> >
> > Ping. =A0Shall I apply the patch?
> >
> I am sorry for the delay in acking your response.  Your patch looks g=
ood to me.

Thanks.  Acked-by added.

--=20
tejun
