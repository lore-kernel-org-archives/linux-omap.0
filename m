From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 12/17] ARM: OMAP2+: remove misuse of IRQF_NO_SUSPEND flag
Date: Mon, 12 Oct 2015 13:20:47 -0700
Message-ID: <20151012202047.GR23801@atomide.com>
References: <1442850433-5903-1-git-send-email-sudeep.holla@arm.com>
 <1442850433-5903-13-git-send-email-sudeep.holla@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1442850433-5903-13-git-send-email-sudeep.holla@arm.com>
Sender: linux-pm-owner@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Sudeep Holla <sudeep.holla@arm.com> [150921 08:52]:
> The IRQF_NO_SUSPEND flag is used to identify the interrupts that should
> be left enabled so as to allow them to work as expected during the
> suspend-resume cycle, but doesn't guarantee that it will wake the system
> from a suspended state, enable_irq_wake is recommended to be used for
> the wakeup.
> 
> This patch removes the use of IRQF_NO_SUSPEND flags replacing it with
> enable_irq_wake instead.

Applying into omap-for-v4.4/cleanup thanks.

Tony
