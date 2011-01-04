From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 01/32] arm/omap: use system_wq in mailbox
Date: Tue, 4 Jan 2011 06:24:21 +0100
Message-ID: <20110104052421.GD6748@mtj.dyndns.org>
References: <1294062595-30097-1-git-send-email-tj@kernel.org>
 <1294062595-30097-2-git-send-email-tj@kernel.org>
 <AANLkTimMK2Ec8SQiRyRBR+MdVKhAmMaaf+oa0VK3wWsf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <AANLkTimMK2Ec8SQiRyRBR+MdVKhAmMaaf+oa0VK3wWsf@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Cc: linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hello,

On Mon, Jan 03, 2011 at 03:35:45PM -0600, Kanigeri, Hari wrote:
> This was changed to dedicated work queue because of performance issues
> when there is heavy mailbox traffic between the cores.
> 
> Reference:
> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg24240.html

Using dedicated workqueue or system_wq doesn't make any difference in
terms of execution latency anymore.  Sleeping work items no longer
delay execution of other work items.  If mailbox is very latency
sensitive, it might make sense to create a HIGHPRI workqueue but that
usually isn't necessary.

Thank you.

--
tejun
