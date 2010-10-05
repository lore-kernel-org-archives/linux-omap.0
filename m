From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 1/1] omap: Ptr "isr_reg" tracked as NULL was
 dereferenced
Date: Tue, 5 Oct 2010 12:32:06 +0300
Message-ID: <20101005093206.GB2977@legolas.emea.dhcp.ti.com>
References: <cover.1286261378.git.EXT-Eugeny.Kuznetsov@nokia.com>
 <131d16236d19895323fca2f058d65f1f116bacad.1286261378.git.EXT-Eugeny.Kuznetsov@nokia.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <131d16236d19895323fca2f058d65f1f116bacad.1286261378.git.EXT-Eugeny.Kuznetsov@nokia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Evgeny Kuznetsov <EXT-Eugeny.Kuznetsov@nokia.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "zmc@lurian.net" <zmc@lurian.net>, "a.j.buxton@gmail.com" <a.j.buxton@gmail.com>
List-Id: linux-omap@vger.kernel.org

Hi,

On Tue, Oct 05, 2010 at 03:42:10AM -0500, Evgeny Kuznetsov wrote:
>+	if (!isr_reg) {
>+		printk(KERN_ERR "FATAL: Incorrect GPIO method %i\n",
>+				bank->method);
>+		BUG();
>+		}

this could be simply:

BUG_ON(!isr_reg);

-- 
balbi
