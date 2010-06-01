From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [RFC] [PATCH v3 1/4] OMAP4: Keyboard controller support
Date: Tue, 1 Jun 2010 09:14:20 +0300
Message-ID: <20100601061420.GB6465@nokia.com>
References: <27F9C60D11D683428E133F85D2BB4A53043E537F73@dlee03.ent.ti.com>
 <20100601044318.GA13883@nokia.com>
 <20100601060954.GB7391@core.coreip.homeip.net>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20100601060954.GB7391@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
To: ext Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>, "ext Arce, Abraham" <x0066660@ti.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Jun 01, 2010 at 08:09:54AM +0200, ext Dmitry Torokhov wrote:
>There isn't such member in matrix_keymap_data, it only contains length
>of the keymap.

sorry, I had the idea in mind that KEY(row, col, val) would do something 
different.

-- 
balbi

DefectiveByDesign.org
