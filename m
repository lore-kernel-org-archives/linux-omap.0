From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] musb_hdrc: Add Nokia Copyright,
	Make GPLv2 text generic (Was: [PATCH 8/8] musb_hdrc: Tabify and
	clean-up musbhdrc.h)
Date: Thu, 16 Aug 2007 00:50:42 -0700
Message-ID: <200708160050.42294.david-b@pacbell.net>
References: <11871877051923-git-send-email-tony@atomide.com>
	<200708150920.46534.david-b@pacbell.net>
	<20070816064635.GA20381@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20070816064635.GA20381@atomide.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Wednesday 15 August 2007, Tony Lindgren wrote:
> --- a/drivers/usb/musb/musbhdrc.h
> +++ b/drivers/usb/musb/musbhdrc.h

Seems right to me -- applied to all files, not just this one.


> @@ -1,34 +1,35 @@
>  /*
> + * MUSB OTG driver register defines
> + *
>   * Copyright 2005 Mentor Graphics Corporation
>   * Copyright (C) 2005-2006 by Texas Instruments
> + * Copyright (C) 2006-2007 Nokia Corporation
>   *
> - * This file is part of the Inventra Controller Driver for Linux.
> - *
> - * The Inventra Controller Driver for Linux is free software; you
> - * can redistribute it and/or modify it under the terms of the GNU
> - * General Public License version 2 as published by the Free Software
> - * Foundation.
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * version 2 as published by the Free Software Foundation.

Right, "This program" is what's covered by GPL, label is irrelevant.

>   *
> - * The Inventra Controller Driver for Linux is distributed in
> - * the hope that it will be useful, but WITHOUT ANY WARRANTY;
> - * without even the implied warranty of MERCHANTABILITY or
> - * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
> - * License for more details.
> + * This program is distributed in the hope that it will be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * General Public License for more details.
>   *
>   * You should have received a copy of the GNU General Public License
> - * along with The Inventra Controller Driver for Linux ; if not,
> - * write to the Free Software Foundation, Inc., 59 Temple Place,
> - * Suite 330, Boston, MA  02111-1307  USA
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
> + * 02110-1301 USA

Again, same except for "This program" ...


> + *
> + * THIS SOFTWARE IS PROVIDED "AS IS" AND ANY EXPRESS OR IMPLIED
> + * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
> + * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
> + * NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,

Strictly speaking "AUTHORS" might be better ...

> + * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
> + * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF
> + * USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
> + * ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
> + * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
> + * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
>   *
> - * ANY DOWNLOAD, USE, REPRODUCTION, MODIFICATION OR DISTRIBUTION
> - * OF THIS DRIVER INDICATES YOUR COMPLETE AND UNCONDITIONAL ACCEPTANCE
> - * OF THOSE TERMS.THIS DRIVER IS PROVIDED "AS IS" AND MENTOR GRAPHICS
> - * MAKES NO WARRANTIES, EXPRESS OR IMPLIED, RELATED TO THIS DRIVER.
> - * MENTOR GRAPHICS SPECIFICALLY DISCLAIMS ALL IMPLIED WARRANTIES
> - * OF MERCHANTABILITY; FITNESS FOR A PARTICULAR PURPOSE AND
> - * NON-INFRINGEMENT.  MENTOR GRAPHICS DOES NOT PROVIDE SUPPORT
> - * SERVICES OR UPDATES FOR THIS DRIVER, EVEN IF YOU ARE A MENTOR
> - * GRAPHICS SUPPORT CUSTOMER.

Not quite the same, but they're not allowed to add or remove
constraints from the GPL, so this is more correct.


>   */
>  
>  #ifndef __MUSB_HDRC_DEFS_H__
> 
