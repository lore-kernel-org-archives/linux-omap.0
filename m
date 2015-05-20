From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/5] PM / Runtime: Update last_busy in rpm_resume
Date: Wed, 20 May 2015 09:36:41 +0200
Message-ID: <CAPDyKFqUthtbjP-4X4Qu6jxVkLe7s6tANyttqGUWToihKkww1Q@mail.gmail.com>
References: <1431560196-5722-1-git-send-email-tony@atomide.com>
	<1431560196-5722-2-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <1431560196-5722-2-git-send-email-tony@atomide.com>
Sender: linux-pm-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Alan Stern <stern@rowland.harvard.edu>, Andreas Fenkart <afenkart@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Felipe Balbi <balbi@ti.com>, Huiquan Zhong <huiquan.zhong@intel.com>, Kevin Hilman <khilman@kernel.org>, NeilBrown <neilb@suse.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, Nishanth Menon <nm@ti.com>, Peter Hurley <peter@hurleysoftware.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org, linux-omap <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On 14 May 2015 at 01:36, Tony Lindgren <tony@atomide.com> wrote:
> If we don't update last_busy in rpm_resume, devices can go back
> to sleep immediately after resume. This happens at least in
> cases where the device has been powered off and does not have
> any interrupt pending until there's something in the FIFO.
>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

If it's not too late,

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe
