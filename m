From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH 1/5] usb: dwc3: ep0: use _roundup_ to calculate the transfer
 size
Date: Fri, 10 Jul 2015 20:29:19 +0530
Message-ID: <559FDDC7.5020000@ti.com>
References: <1433927932-32395-1-git-send-email-kishon@ti.com> <1433927932-32395-2-git-send-email-kishon@ti.com> <20150706190003.GM20779@saruman.tx.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150706190003.GM20779@saruman.tx.rr.com>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@ti.com
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, nsekhar@ti.com, gregkh@linuxfoundation.org
List-Id: linux-omap@vger.kernel.org

Hi Felipe,

On Tuesday 07 July 2015 12:30 AM, Felipe Balbi wrote:
> On Wed, Jun 10, 2015 at 02:48:48PM +0530, Kishon Vijay Abraham I wrote:
>> No functional change. Used _roundup_ macro to calculate the transfer
>> size aligned to maxpacket in  dwc3_ep0_complete_data. It also makes it
>> similar to how transfer size is calculated in __dwc3_ep0_do_control_data.
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> 
> doesn't apply, can you rebase on testing/next ?

sure, will send it by early next week.

Thanks
Kishon
