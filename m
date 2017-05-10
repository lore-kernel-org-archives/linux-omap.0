From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 00/10] usb: musb: tusb6010_omap: Convert to DMAengine
Date: Wed, 10 May 2017 09:32:13 -0700
Message-ID: <20170510163213.GO3489@atomide.com>
References: <20170510084231.19302-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170510084231.19302-1-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: b-liu@ti.com, gregkh@linuxfoundation.org, vinod.koul@intel.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, balbi@kernel.org, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [170510 01:45]:
> The device would not boot to prompt most of the time before patch 5 (packet size
> reset fix).
> With that patch in, the device would boot up fine most of the cases, but will
> fail pretty fast with my stress test [1].
> After the first 9 patch the legacy DMA mode is going to be stable with g_ncm, it
> boots to prompt, and survives the stress test [1].

Best to merge that as a separate fix.

I already replied with acks to few patches, and for the entire
series please feel free to add:

Tested-by: Tony Lindgren <tony@atomide.com>
