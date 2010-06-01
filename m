From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [RFC] [PATCH v3 3/4] OMAP4: Keyboard board support
Date: Tue, 1 Jun 2010 07:48:13 +0300
Message-ID: <20100601044813.GC13883@nokia.com>
References: <27F9C60D11D683428E133F85D2BB4A53043E537F75@dlee03.ent.ti.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <27F9C60D11D683428E133F85D2BB4A53043E537F75@dlee03.ent.ti.com>
Sender: linux-input-owner@vger.kernel.org
To: "ext Arce, Abraham" <x0066660@ti.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>
List-Id: linux-omap@vger.kernel.org

On Mon, May 31, 2010 at 11:45:39PM +0200, ext Arce, Abraham wrote:
>+static struct omap4_keypad_platform_data sdp4430_keypad_data = {
>+	.keymap_data		= &sdp4430_keymap_data,
>+	.rows			= 8,
>+	.cols			= 8,
>+	.device_enable		= omap_device_enable,
>+	.device_shutdown	= omap_device_shutdown,
>+	.device_idle		= omap_device_idle,

again all three are undefined

-- 
balbi

DefectiveByDesign.org
