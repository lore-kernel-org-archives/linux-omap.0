From: Matthijs van Duin <matthijsvanduin@gmail.com>
Subject: Re: [4.8.0-rc1] am335x-evm boot failure: n_tty_receive_buf_common:
 "Unable to handle kernel paging request.."
Date: Sat, 10 Sep 2016 01:53:27 +0200
Message-ID: <CAALWOA-e6SZEW67akn_EGnCPzfZbuw-wjwu-j1dfuucoCA5ecg@mail.gmail.com>
References: <87ceb885-94a6-b9b3-60b3-2017198c4338@ti.com> <CAALWOA_=9fMG156H_XSZBjeckQUK-moDWoRE6_kr-8=Z_-KZuA@mail.gmail.com>
 <20160909234742.becrs3zb4ihc2mq6@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160909234742.becrs3zb4ihc2mq6@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Peter Hurley <peter@hurleysoftware.com>, Lokesh Vutla <lokeshvutla@ti.com>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On 10 September 2016 at 01:47, Tony Lindgren <tony@atomide.com> wrote:
> Yeah. Just disable omap_l3_smx/noc driver and you should see
> a proper stack trace. With the L3 driver we're seeing the trace
> for L3 error interrupt.

Huh what, I see a proper stack trace in his post? I'm pretty sure
omap_l3_noc doesn't even support am335x currently.

Matthijs
