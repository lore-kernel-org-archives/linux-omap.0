From: "Mohammed, Afzal" <afzal@ti.com>
Subject: RE: [PATCH v7 21/21] OMAP2+: UART: Do not gate uart clocks if used
 for	debug_prints
Date: Wed, 19 Oct 2011 11:05:02 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593032869342E@dbde02.ent.ti.com>
References: <1318952141-10697-1-git-send-email-govindraj.raja@ti.com>
 <1318952141-10697-2-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <1318952141-10697-2-git-send-email-govindraj.raja@ti.com>
Content-Language: en-US
Sender: linux-serial-owner@vger.kernel.org
To: "R, Govindraj" <govindraj.raja@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Hilman, Kevin" <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, "Nayak, Rajendra" <rnayak@ti.com>, "Basak, Partha" <p-basak2@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Hi Govindraj,

On Tue, Oct 18, 2011 at 21:05:41, R, Govindraj wrote:
> If OMAP UART is used as console uart and debug is enabled,
> avoid gating of uart clocks to print all debug prints.
: 
:
>  			console_uart_id = uart->num;
>  
> +			if (cmdline_find_option("debug")) {
> +				uart_debug = true;

Shouldn't "loglevel" also be checked?

Regards
Afzal
