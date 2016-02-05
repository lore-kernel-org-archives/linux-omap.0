From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: dra7xx driver status
Date: Fri, 5 Feb 2016 09:45:29 +0530
Message-ID: <56B421E1.9090005@ti.com>
References: <20160204204534.GC7031@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20160204204534.GC7031@localhost>
Sender: linux-pci-owner@vger.kernel.org
To: Bjorn Helgaas <helgaas@kernel.org>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-pci@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Bjorn,

On Friday 05 February 2016 02:15 AM, Bjorn Helgaas wrote:
> Hi Kishon,
> 
> What's the state of dra7xx?  In my tree, it's still marked with
> CONFIG_BROKEN.  Last I heard there was a reset issue that needed to
> be worked out, but I don't know whether that's been done yet.

I've posted pdata-quirks mechanism to do the reset (which will get PCIe
working). Tony had some comments and we are expecting feedback from Paul. I'll
ping him again in that thread.

Thanks
Kishon
> 
> Bjorn
> 
