From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v8 00/20] OMAP2+: UART: Runtime adaptation + cleanup
Date: Tue, 13 Dec 2011 15:32:07 -0800
Message-ID: <87zkewt5e0.fsf@ti.com>
References: <1321005446-21741-1-git-send-email-govindraj.raja@ti.com>
	<CAAL8m4wGN5ykm3-+xrGPe-WJUDBdterxAyZ=C3kH862+n1DprQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <CAAL8m4wGN5ykm3-+xrGPe-WJUDBdterxAyZ=C3kH862+n1DprQ@mail.gmail.com>
	(Govindraj's message of "Tue, 13 Dec 2011 18:31:13 +0530")
Sender: linux-serial-owner@vger.kernel.org
To: Govindraj <govindraj.ti@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Partha Basak <p-basak2@ti.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, "Govindraj.R" <govindraj.raja@ti.com>
List-Id: linux-omap@vger.kernel.org

Govindraj <govindraj.ti@gmail.com> writes:

[...]

> I have re-based this patch series against LO master
> commit id: deee6d5359969a0ce4e2760cfd7b9f379bd5698a
>
> Same is available here [1]
>
> I have tested this patch series along with:
>
> 1.) Tero's V11 irq chaining series
>      http://www.spinics.net/lists/linux-omap/msg61445.html
>     (This patch series is used for uart wakeup handling using
>       prcm_irq chaining)
>
> 2.) Rajendra's hwmod change
>      http://www.spinics.net/lists/arm-kernel/msg148632.html
>      (This patch handles init_no_idle flag setting
>       without this patch there will be boot warning however
>       all pm features will work after boot up.)

Actually, without Rajendra's patch all features do not work.  I don't
get UART console wakeups from idle (with runtime PM autosuspend enabled)
on 3430/n900 or 3530/Overo without Rajendra's patch.

Kevin
