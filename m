From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: Enabling Mistral touch screen driver
Date: Sun, 14 May 2006 17:45:04 +0200
Message-ID: <44675080.1040503@gmail.com>
References: <4465A8C0.4020100@nextbitcpu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <4465A8C0.4020100@nextbitcpu.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Vishal Borker <vishal@nextbitcpu.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Vishal Borker wrote:
> Was interested in finding asto what i 
> would need to do to enable the touchscreen component & support. both, on 
> the kernel ...

Seach list archive for 'tslib' and 'touchscreen'.

Use userspace tslib for touchscreen handling:

http://cvs.arm.linux.org.uk/

-> tslib

Kernel configuration for this:

CONFIG_OMAP_OSK_MISTRAL=y
CONFIG_OMAP_UWIRE=y
CONFIG_INPUT_TOUCHSCREEN=y
CONFIG_TOUCHSCREEN_OMAP=y

 > ... as well as microwindows side.

Search list archive for 'microwindows' as well.

Regards

Dirk
