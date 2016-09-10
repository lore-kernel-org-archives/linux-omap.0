From: Tony Lindgren <tony@atomide.com>
Subject: Re: [4.8.0-rc1] am335x-evm boot failure: n_tty_receive_buf_common:
 "Unable to handle kernel paging request.."
Date: Sat, 10 Sep 2016 06:10:04 -0700
Message-ID: <20160910131002.6zyzybd6kcklt6yx@atomide.com>
References: <87ceb885-94a6-b9b3-60b3-2017198c4338@ti.com>
 <CAALWOA_=9fMG156H_XSZBjeckQUK-moDWoRE6_kr-8=Z_-KZuA@mail.gmail.com>
 <20160909234742.becrs3zb4ihc2mq6@atomide.com>
 <CAALWOA-e6SZEW67akn_EGnCPzfZbuw-wjwu-j1dfuucoCA5ecg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAALWOA-e6SZEW67akn_EGnCPzfZbuw-wjwu-j1dfuucoCA5ecg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthijs van Duin <matthijsvanduin@gmail.com>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Peter Hurley <peter@hurleysoftware.com>, Lokesh Vutla <lokeshvutla@ti.com>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

* Matthijs van Duin <matthijsvanduin@gmail.com> [160909 16:54]:
> On 10 September 2016 at 01:47, Tony Lindgren <tony@atomide.com> wrote:
> > Yeah. Just disable omap_l3_smx/noc driver and you should see
> > a proper stack trace. With the L3 driver we're seeing the trace
> > for L3 error interrupt.
> 
> Huh what, I see a proper stack trace in his post? I'm pretty sure
> omap_l3_noc doesn't even support am335x currently.

Oh OK sorry please ignore the post, I obviously did not look at
the trace but assumed that was the case based on what I've seen.

Yeah I don't think we have L3 interrupts working for am335x.

Regards,

Tony
