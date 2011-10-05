From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v6 07/16] OMAP2+: UART: Add default mux for all uarts.
Date: Wed, 05 Oct 2011 12:04:54 -0700
Message-ID: <87zkhf9s4p.fsf@ti.com>
References: <1317380495-584-1-git-send-email-govindraj.raja@ti.com>
	<1317380495-584-7-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <1317380495-584-7-git-send-email-govindraj.raja@ti.com>
	(Govindraj R.'s message of "Fri, 30 Sep 2011 16:31:33 +0530")
Sender: linux-serial-owner@vger.kernel.org
To: "Govindraj.R" <govindraj.raja@ti.com>
Cc: linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Partha Basak <p-basak2@ti.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>
List-Id: linux-omap@vger.kernel.org

"Govindraj.R" <govindraj.raja@ti.com> writes:

> Prior to this change rx-pad wakeup was done by writing to rx-pad offset value
> populated in serial.c idle_init. Now with mux framework support we can use
> mux_utilities along with hmwod framework to handle io-pad configuration and
> enable rx-pad wake-up mechanism.

This patch (along with a few others) have compile errors when CONFIG_PM
is not set.

Kevin
