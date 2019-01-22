From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 4/4] arm: omap2: no need to check return value of
 debugfs_create functions
Date: Tue, 22 Jan 2019 15:06:51 -0800
Message-ID: <20190122230651.GD5720@atomide.com>
References: <20190122144114.9816-1-gregkh@linuxfoundation.org>
 <20190122144114.9816-5-gregkh@linuxfoundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190122144114.9816-5-gregkh@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Kevin Hilman <khilman@kernel.org>, Russell King <linux@armlinux.org.uk>, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Greg Kroah-Hartman <gregkh@linuxfoundation.org> [190122 14:41]:
> When calling debugfs functions, there is no need to ever check the
> return value.  The function can work or not, but the code logic should
> never do something different based on this.

Acked-by: Tony Lindgren <tony@atomide.com>
