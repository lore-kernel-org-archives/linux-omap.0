From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] musb_hdrc: Add Nokia Copyright, Make GPLv2 text generic
	(Was: [PATCH 8/8] musb_hdrc: Tabify and clean-up musbhdrc.h)
Date: Wed, 15 Aug 2007 23:46:36 -0700
Message-ID: <20070816064635.GA20381@atomide.com>
References: <11871877051923-git-send-email-tony@atomide.com>
	<11871877263342-git-send-email-tony@atomide.com>
	<11871877282691-git-send-email-tony@atomide.com>
	<200708150920.46534.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="CE+1k2dSO48ffgeK"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <200708150920.46534.david-b@pacbell.net>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* David Brownell <david-b@pacbell.net> [070815 09:20]:
> On Wednesday 15 August 2007, Tony Lindgren wrote:
> > Tabify and clean-up musbhdrc.h
> 
> All those patches look nice to me, FWIW.  :)

OK, will push them today.

> I'd suggest sticking "Copyright (C) 2006-2007 Nokia Corporation" on
> the code too.  With the amount of work this driver needed, I think
> more people than just Mentor and TI deserve credit for whipping it
> into shape!

Will do. I think we should also update the license text with standard
GPLv2 as the current one mentions "Inventra Controller Driver" and
"Mentor Graphics", while GPLv2 really covers all the various parties
who have been working on the code.

Following patch is what I have in mind, with the added Nokia copyright.
If this sounds OK to people, I'll submit patches to update all the
licenses.

Tony

--CE+1k2dSO48ffgeK
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="musb-license-gplv2-generic.patch"

--- a/drivers/usb/musb/musbhdrc.h
+++ b/drivers/usb/musb/musbhdrc.h
@@ -1,34 +1,35 @@
 /*
+ * MUSB OTG driver register defines
+ *
  * Copyright 2005 Mentor Graphics Corporation
  * Copyright (C) 2005-2006 by Texas Instruments
+ * Copyright (C) 2006-2007 Nokia Corporation
  *
- * This file is part of the Inventra Controller Driver for Linux.
- *
- * The Inventra Controller Driver for Linux is free software; you
- * can redistribute it and/or modify it under the terms of the GNU
- * General Public License version 2 as published by the Free Software
- * Foundation.
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
  *
- * The Inventra Controller Driver for Linux is distributed in
- * the hope that it will be useful, but WITHOUT ANY WARRANTY;
- * without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
- * License for more details.
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
  *
  * You should have received a copy of the GNU General Public License
- * along with The Inventra Controller Driver for Linux ; if not,
- * write to the Free Software Foundation, Inc., 59 Temple Place,
- * Suite 330, Boston, MA  02111-1307  USA
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
+ * 02110-1301 USA
+ *
+ * THIS SOFTWARE IS PROVIDED "AS IS" AND ANY EXPRESS OR IMPLIED
+ * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
+ * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
+ * NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
+ * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF
+ * USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
+ * ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
+ * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  *
- * ANY DOWNLOAD, USE, REPRODUCTION, MODIFICATION OR DISTRIBUTION
- * OF THIS DRIVER INDICATES YOUR COMPLETE AND UNCONDITIONAL ACCEPTANCE
- * OF THOSE TERMS.THIS DRIVER IS PROVIDED "AS IS" AND MENTOR GRAPHICS
- * MAKES NO WARRANTIES, EXPRESS OR IMPLIED, RELATED TO THIS DRIVER.
- * MENTOR GRAPHICS SPECIFICALLY DISCLAIMS ALL IMPLIED WARRANTIES
- * OF MERCHANTABILITY; FITNESS FOR A PARTICULAR PURPOSE AND
- * NON-INFRINGEMENT.  MENTOR GRAPHICS DOES NOT PROVIDE SUPPORT
- * SERVICES OR UPDATES FOR THIS DRIVER, EVEN IF YOU ARE A MENTOR
- * GRAPHICS SUPPORT CUSTOMER.
  */
 
 #ifndef __MUSB_HDRC_DEFS_H__

--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--CE+1k2dSO48ffgeK--
