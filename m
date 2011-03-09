From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 5/7] Serial: OMAP: add runtime pm support for omap-serial
 driver
Date: Tue, 8 Mar 2011 19:02:44 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1103081849360.15132@utopia.booyaka.com>
References: <1298903958-6496-1-git-send-email-govindraj.raja@ti.com> <1298903958-6496-6-git-send-email-govindraj.raja@ti.com> <87r5am499h.fsf@ti.com> <AANLkTim35McK1cFFEXyS49D6b8CT+4pQfmKAswOn3e7_@mail.gmail.com> <87hbbdjc7y.fsf@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <87hbbdjc7y.fsf@ti.com>
Sender: linux-serial-owner@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Govindraj <govindraj.ti@gmail.com>, "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Rajendra Nayak <rnayak@ti.com>
List-Id: linux-omap@vger.kernel.org


Hi Govindraj,

what also would be good to find out is why the UART is apparently sending 
asynchronous wakeups even when the driver doesn't set 
SCR_REG.RX_CTS_WU_EN.  This seems contrary to the expectation that 34xx 
TRM vZH section 17.4.4.1.4.1 "Wake-up Interrupt" sets.  Could you please 
clarify under which circumstances the RX_CTS_WU_EN bit is used?  I suppose 
that, given that it's also mentioned under section 17.4.5.1.1 "Module 
Power Savings", it might only be used when SLEEP_MODE is enabled.


- Paul
