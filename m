From: "Ivan T. Ivanov" <iivanov@mm-sol.com>
Subject: Re: [PATCH v5 1/3] usb: dwc3: msm: Add device tree binding
 information
Date: Tue, 01 Oct 2013 15:08:30 +0300
Message-ID: <1380629310.30666.22.camel@iivanov-dev.int.mm-sol.com>
References: <1377091786-5613-1-git-send-email-iivanov@mm-sol.com>
	 <1377091786-5613-2-git-send-email-iivanov@mm-sol.com>
	 <20130923193224.GO30811@radagast>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130923193224.GO30811@radagast>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@ti.com
Cc: rob.herring@calxeda.com, pawel.moll@arm.com, mark.rutland@arm.com, swarren@wwwdotorg.org, ian.campbell@citrix.com, rob@landley.net, gregkh@linuxfoundation.org, grant.likely@linaro.org, idos@codeaurora.org, mgautam@codeaurora.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-msm@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-omap@vger.kernel.org


Hi,

On Mon, 2013-09-23 at 14:32 -0500, Felipe Balbi wrote: 
> Hi,
> 
> On Wed, Aug 21, 2013 at 04:29:44PM +0300, Ivan T. Ivanov wrote:
> > From: "Ivan T. Ivanov" <iivanov@mm-sol.com>
> > 
> > MSM USB3.0 core wrapper consist of USB3.0 IP from Synopsys
> > (SNPS) and HS, SS PHY's control and configuration registers.
> > 
> > It could operate in device mode (SS, HS, FS) and host
> > mode (SS, HS, FS, LS).
> > 
> > Signed-off-by: Ivan T. Ivanov <iivanov@mm-sol.com>
> 
> and here's a new version from same patch

The only difference is that references to "dwc3" are replaced with
just "dw" in USB PHY drivers and file names. This is to indicate
that the PHY's are DesignWare, but not necessarily related to
DWC3 IP core. If you prefer I could keep old abbreviation.

Thanks, 
Ivan
