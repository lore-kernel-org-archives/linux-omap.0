From: Colin Cross <ccross@android.com>
Subject: Re: [PATCH] ARM: omap4: Pass core and wakeup mux tables to omap4_mux_init
Date: Tue, 31 May 2011 11:50:23 -0700
Message-ID: <BANLkTikfXs1oLott64+C5wy59G24Mux0TJ52et7GTEMQrfqRFQ@mail.gmail.com>
References: <1304546278-28965-1-git-send-email-ccross@android.com>
	<20110531124208.GF11352@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110531124208.GF11352@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Russell King <linux@arm.linux.org.uk>, l-o <linux-omap@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Tue, May 31, 2011 at 5:42 AM, Tony Lindgren <tony@atomide.com> wrote:
> * Colin Cross <ccross@android.com> [110504 14:54]:
>> OMAP4 contains two separate instances of the padconf registers,
>> one in the core system config and one in the wakeup system config.
>> Pass in two tables to apply the correct values to each instance.
>
> Hmm good catch thanks. Will queue this as a fix.

This patch doesn't work without another fix to allow NULL to be passed
to omap4_mux_init.  Do you prefer allowing NULL, or adding empty
board_wkup_mux arrays to every board file?  I have a patch for the
first option.
