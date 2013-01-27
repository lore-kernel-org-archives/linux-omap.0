From: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: [PATCH v3 3/8] input: touchscreen: ti_tsc: remove unwanted fifo flush
Date: Sun, 27 Jan 2013 14:55:41 +0100
Message-ID: <87zjzubuhu.fsf@dell.be.48ers.dk>
References: <cover.1358502134.git.rachna@ti.com>
	<0110c0cb0cbd3c31dfd3f098f207cd5b765d247e.1358502134.git.rachna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <0110c0cb0cbd3c31dfd3f098f207cd5b765d247e.1358502134.git.rachna@ti.com>
	(Rachna Patil's message of "Fri, 18 Jan 2013 16:18:06 +0530")
Sender: linux-input-owner@vger.kernel.org
To: "Patil, Rachna" <rachna@ti.com>
Cc: linux-doc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-iio@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Russell King <linux@arm.linux.org.uk>, Samuel Ortiz <sameo@linux.intel.com>, Dmitry Torokhov <dtor@mail.ru>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <rob.herring@calxeda.com>, Jonathan Cameron <jic23@cam.ac.uk>
List-Id: linux-omap@vger.kernel.org

>>>>> "P" == Patil, Rachna <rachna@ti.com> writes:

 P> From: "Patil, Rachna" <rachna@ti.com>
 P> When touchscreen and ADC are used together, this
 P> unwanted fifo flush leads to loss of ADC data.

Any special reason why you're wrapping your commit messages after 50
chars, and not the more standard ~70 chars?

It would be good with some more detailed commit text. Is the flush done
somewhere else now? What happens on boards where you don't use the adc
part?

-- 
Bye, Peter Korsgaard
