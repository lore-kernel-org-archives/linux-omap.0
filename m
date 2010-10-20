From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v2 3/3] drivers: cleanup Kconfig stuff
Date: Wed, 20 Oct 2010 09:35:38 +0300
Message-ID: <20101020063538.GG15448@legolas.emea.dhcp.ti.com>
References: <20101019103234.GI31170@legolas.emea.dhcp.ti.com>
 <AANLkTinXzMQXoyyu+anSCvSuE9w3FWAP5HswDS0kfpzE@mail.gmail.com>
 <20101019111613.GJ31170@legolas.emea.dhcp.ti.com>
 <AANLkTikkMphKa2DGGtWxy-3LpFX0kn92UEYPj==Euzok@mail.gmail.com>
 <20101019115236.GL31170@legolas.emea.dhcp.ti.com>
 <AANLkTim3NsgjC3Nh8VCCrx4cV1Y+kn38=30=en0KCft6@mail.gmail.com>
 <6ea089ac75d4d15d88698468eacb7fe3@secure211.sgcpanel.com>
 <AANLkTinYM5aavk9_jcTTymff=OY+Yyv8T6C+dmMih0p_@mail.gmail.com>
 <20101019234414.GB30991@atomide.com>
 <87fww1u3fw.fsf@deeprootsystems.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87fww1u3fw.fsf@deeprootsystems.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Tony Lindgren <tony@atomide.com>, Felipe Contreras <felipe.contreras@gmail.com>, Felipe Balbi <me@felipebalbi.com>, "Balbi, Felipe" <balbi@ti.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, linux-main <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>
List-Id: linux-omap@vger.kernel.org

Hi,

On Tue, Oct 19, 2010 at 07:13:07PM -0500, Kevin Hilman wrote:
>One thing I don't like about this is that there is currently no way to
>'select' as a module.

Yeah, I remember suggesting to add "module" to Kconfig language which
would do the job of selecting as module.

-- 
balbi
