From: "Cherian, George" <george.cherian@ti.com>
Subject: RE: [PATCH 1/4] usb: dwc3: gadget: free trb pool only from epnum 2
Date: Mon, 27 May 2013 09:30:49 +0000
Message-ID: <BD228B1E3C6D7740B44C214F9AEEACE335E02F@DBDE04.ent.ti.com>
References: <1369645549-14867-1-git-send-email-george.cherian@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1369645549-14867-1-git-send-email-george.cherian@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "Balbi, Felipe" <balbi@ti.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
List-Id: linux-omap@vger.kernel.org



> -----Original Message-----
> From: Cherian, George
> Sent: Monday, May 27, 2013 2:36 PM
> To: linux-usb@vger.kernel.org; linux-omap@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Cc: Balbi, Felipe; gregkh@linuxfoundation.org; Cherian, George
> Subject: [PATCH 1/4] usb: dwc3: gadget: free trb pool only from epnum 2

Please read [PATCH 1/4] as [PATCH 1/1].
> 
> we never allocate a TRB pool for physical endpoints
> 0 and 1 so trying to free it (a invalid TRB pool pointer)
> will lead us in a warning while removing dwc3.ko module.
> 
> In order to fix the situation, all we have to do is skip
> dwc3_free_trb_pool() for physical endpoints 0 and 1 just
> as we while deleting endpoints from the endpoints list.
> 
> Signed-off-by: George Cherian <george.cherian@ti.com>
> Signed-off-by: Felipe Balbi <balbi@ti.com>
