From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: Re: [PATCH 1/2] DSPBRIDGE: Remove autoconf.h dependency from host_os
 header
Date: Tue, 23 Mar 2010 12:28:22 -0500
Message-ID: <4BA8FA36.2030609@ti.com>
References: <1268949429-30368-1-git-send-email-omar.ramirez@ti.com> <1268949429-30368-2-git-send-email-omar.ramirez@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46752 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753267Ab0CWR21 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 23 Mar 2010 13:28:27 -0400
In-Reply-To: <1268949429-30368-2-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@gmail.com>, Ameya Palande <ameya.palande@nokia.com>, "Guzman Lugo, Fernando" <x0095840@ti.com>, "Kanigeri, Hari" <h-kanigeri2@ti.com>, Omar Ramirez Luna <omar.ramirez@hotmail.com>

On 3/18/2010 4:57 PM, Ramirez Luna, Omar wrote:
> There shouldn't be any dependency on the definitions generated
> by autoconf.h, besides it is automatically included by the
> build system.
>
> This solves the following warning:
>
> In file included from arch/arm/plat-omap/include/dspbridge/host_os.h:20,
>                   from arch/arm/mach-omap2/io.c:51:
> include/linux/autoconf.h:165:1: warning: "CONFIG_DEFAULT_IOSCHED" redefined
> In file included from<command-line>:0:
> ./include/generated/autoconf.h:172:1: warning: this is the location of the previous definition
>
> Signed-off-by: Omar Ramirez Luna<omar.ramirez@hotmail.com>
> ---
>   arch/arm/plat-omap/include/dspbridge/host_os.h |    1 -
>   1 files changed, 0 insertions(+), 1 deletions(-)
>

Pushed to dspbridge.

- omar
