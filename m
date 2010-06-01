From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [RFC] [PATCH v3 2/4] OMAP4: Keyboard device registration
Date: Tue, 1 Jun 2010 07:49:19 +0300
Message-ID: <20100601044919.GD13883@nokia.com>
References: <27F9C60D11D683428E133F85D2BB4A53043E537F74@dlee03.ent.ti.com>
 <20100601044734.GB13883@nokia.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20100601044734.GB13883@nokia.com>
Sender: linux-input-owner@vger.kernel.org
To: "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>
Cc: "ext Arce, Abraham" <x0066660@ti.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>
List-Id: linux-omap@vger.kernel.org

On Tue, Jun 01, 2010 at 06:47:34AM +0200, Balbi Felipe (Nokia-D/Helsinki) wrote:
>>+	pdata->device_enable = omap_device_enable;
>
>this is undefined at least here or previous patch.

or does it come from omap_device layers ??

-- 
balbi

DefectiveByDesign.org
