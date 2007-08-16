From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/36] musb_hdrc: Add Nokia copyright,
	make GPLv2 license generic
Date: Thu, 16 Aug 2007 02:40:24 -0700
Message-ID: <11872572612810-git-send-email-tony@atomide.com>
References: <11872572591844-git-send-email-tony@atomide.com>
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <11872572591844-git-send-email-tony@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

This patch adds Nokia copyright, and makes the license text
generic to cover all parties involved by removing "Inventra
Controller Driver" and "Mentor Graphics" specific text from
the license.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/usb/musb/debug.h       |   51 +++++++++++++++++++-------------------
 drivers/usb/musb/dma.h         |   53 ++++++++++++++++++++-------------------
 drivers/usb/musb/g_ep0.c       |   51 +++++++++++++++++++-------------------
 drivers/usb/musb/musb_gadget.c |   51 +++++++++++++++++++-------------------
 drivers/usb/musb/musb_gadget.h |   51 +++++++++++++++++++-------------------
 drivers/usb/musb/musb_host.c   |   52 +++++++++++++++++++-------------------
 drivers/usb/musb/musb_host.h   |   51 +++++++++++++++++++-------------------
 drivers/usb/musb/musb_procfs.c |   51 +++++++++++++++++++-------------------
 drivers/usb/musb/musbdefs.h    |   51 +++++++++++++++++++-------------------
 drivers/usb/musb/musbhdrc.h    |   47 ++++++++++++++++++-----------------
 drivers/usb/musb/musbhsdma.c   |   50 +++++++++++++++++++-------------------
 drivers/usb/musb/plat_arc.h    |   53 +++++++++++++++++++---------------------
 drivers/usb/musb/plat_uds.c    |   52 +++++++++++++++++++-------------------
 drivers/usb/musb/virthub.c     |   52 +++++++++++++++++++-------------------
 14 files changed, 361 insertions(+), 355 deletions(-)

diff --git a/drivers/usb/musb/debug.h b/drivers/usb/musb/debug.h
index ef0c4a7..9f7a032 100644
--- a/drivers/usb/musb/debug.h
+++ b/drivers/usb/musb/debug.h
@@ -1,35 +1,36 @@
-/******************************************************************
+/*
+ * MUSB OTG driver debug defines
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
+ * NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY DIRECT, INDIRECT,
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
- ******************************************************************/
+ */
 
 #ifndef __MUSB_LINUX_DEBUG_H__
 #define __MUSB_LINUX_DEBUG_H__
diff --git a/drivers/usb/musb/dma.h b/drivers/usb/musb/dma.h
index c6c2636..6985340 100644
--- a/drivers/usb/musb/dma.h
+++ b/drivers/usb/musb/dma.h
@@ -1,35 +1,36 @@
-/******************************************************************
+/*
+ * MUSB OTG driver DMA controller abstraction
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
- *
- * ANY DOWNLOAD, USE, REPRODUCTION, MODIFICATION OR DISTRIBUTION
- * OF THIS DRIVER INDICATES YOUR COMPLETE AND UNCONDITIONAL ACCEPTANCE
- * OF THOSE TERMS.THIS DRIVER IS PROVIDED "AS IS" AND MENTOR GRAPHICS
- * MAKES NO WARRANTIES, EXPRESS OR IMPLIED, RELATED TO THIS DRIVER.
- * MENTOR GRAPHICS SPECIFICALLY DISCLAIMS ALL IMPLIED WARRANTIES
- * OF MERCHANTABILITY; FITNESS FOR A PARTICULAR PURPOSE AND
- * NON-INFRINGEMENT.  MENTOR GRAPHICS DOES NOT PROVIDE SUPPORT
- * SERVICES OR UPDATES FOR THIS DRIVER, EVEN IF YOU ARE A MENTOR
- * GRAPHICS SUPPORT CUSTOMER.
- ******************************************************************/
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
+ * 02110-1301 USA
+ *
+ * THIS SOFTWARE IS PROVIDED "AS IS" AND ANY EXPRESS OR IMPLIED
+ * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
+ * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
+ * NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY DIRECT, INDIRECT,
+ * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF
+ * USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
+ * ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
+ * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ */
 
 #ifndef __MUSB_DMA_H__
 #define __MUSB_DMA_H__
diff --git a/drivers/usb/musb/g_ep0.c b/drivers/usb/musb/g_ep0.c
index 9585d00..59cc790 100644
--- a/drivers/usb/musb/g_ep0.c
+++ b/drivers/usb/musb/g_ep0.c
@@ -1,35 +1,36 @@
-/******************************************************************
+/*
+ * MUSB OTG driver ep0 handling
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
- ******************************************************************/
+ * THIS SOFTWARE IS PROVIDED "AS IS" AND ANY EXPRESS OR IMPLIED
+ * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
+ * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
+ * NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY DIRECT, INDIRECT,
+ * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF
+ * USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
+ * ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
+ * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ */
 
 #include <linux/kernel.h>
 #include <linux/list.h>
diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
index 691d1aa..2cb3353 100644
--- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -1,35 +1,36 @@
-/******************************************************************
+/*
+ * MUSB OTG driver peripheral support
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
- ******************************************************************/
+ * THIS SOFTWARE IS PROVIDED "AS IS" AND ANY EXPRESS OR IMPLIED
+ * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
+ * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
+ * NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY DIRECT, INDIRECT,
+ * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF
+ * USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
+ * ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
+ * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ */
 
 #include <linux/kernel.h>
 #include <linux/list.h>
diff --git a/drivers/usb/musb/musb_gadget.h b/drivers/usb/musb/musb_gadget.h
index a4316ed..484b83c 100644
--- a/drivers/usb/musb/musb_gadget.h
+++ b/drivers/usb/musb/musb_gadget.h
@@ -1,35 +1,36 @@
-/******************************************************************
+/*
+ * MUSB OTG driver peripheral defines
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
- ******************************************************************/
+ * THIS SOFTWARE IS PROVIDED "AS IS" AND ANY EXPRESS OR IMPLIED
+ * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
+ * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
+ * NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY DIRECT, INDIRECT,
+ * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF
+ * USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
+ * ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
+ * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ */
 
 #ifndef __MUSB_GADGET_H
 #define __MUSB_GADGET_H
diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
index 99e3dce..cd91e13 100644
--- a/drivers/usb/musb/musb_host.c
+++ b/drivers/usb/musb/musb_host.c
@@ -1,36 +1,36 @@
-/******************************************************************
+/*
+ * MUSB OTG driver host support
+ *
  * Copyright 2005 Mentor Graphics Corporation
  * Copyright (C) 2005-2006 by Texas Instruments
- * Copyright (C) 2006 by Nokia Corporation
- *
- * This file is part of the Inventra Controller Driver for Linux.
+ * Copyright (C) 2006-2007 Nokia Corporation
  *
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
- ******************************************************************/
+ * THIS SOFTWARE IS PROVIDED "AS IS" AND ANY EXPRESS OR IMPLIED
+ * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
+ * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
+ * NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY DIRECT, INDIRECT,
+ * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF
+ * USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
+ * ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
+ * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ */
 
 #include <linux/module.h>
 #include <linux/kernel.h>
diff --git a/drivers/usb/musb/musb_host.h b/drivers/usb/musb/musb_host.h
index 556db74..a0f5a94 100644
--- a/drivers/usb/musb/musb_host.h
+++ b/drivers/usb/musb/musb_host.h
@@ -1,35 +1,36 @@
-/******************************************************************
+/*
+ * MUSB OTG driver host defines
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
- ******************************************************************/
+ * THIS SOFTWARE IS PROVIDED "AS IS" AND ANY EXPRESS OR IMPLIED
+ * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
+ * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
+ * NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY DIRECT, INDIRECT,
+ * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF
+ * USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
+ * ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
+ * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ */
 
 #ifndef _MUSB_HOST_H
 #define _MUSB_HOST_H
diff --git a/drivers/usb/musb/musb_procfs.c b/drivers/usb/musb/musb_procfs.c
index dc77420..535c6e8 100644
--- a/drivers/usb/musb/musb_procfs.c
+++ b/drivers/usb/musb/musb_procfs.c
@@ -1,35 +1,36 @@
-/******************************************************************
+/*
+ * MUSB OTG driver debug support
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
- ******************************************************************/
+ * THIS SOFTWARE IS PROVIDED "AS IS" AND ANY EXPRESS OR IMPLIED
+ * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
+ * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
+ * NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY DIRECT, INDIRECT,
+ * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF
+ * USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
+ * ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
+ * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ */
 
 /*
  * Inventra Controller Driver (ICD) for Linux.
diff --git a/drivers/usb/musb/musbdefs.h b/drivers/usb/musb/musbdefs.h
index eb09ea2..31b81cc 100644
--- a/drivers/usb/musb/musbdefs.h
+++ b/drivers/usb/musb/musbdefs.h
@@ -1,35 +1,36 @@
-/******************************************************************
+/*
+ * MUSB OTG driver defines
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
- ******************************************************************/
+ * THIS SOFTWARE IS PROVIDED "AS IS" AND ANY EXPRESS OR IMPLIED
+ * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
+ * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
+ * NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY DIRECT, INDIRECT,
+ * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF
+ * USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
+ * ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
+ * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ */
 
 #ifndef __MUSB_MUSBDEFS_H__
 #define __MUSB_MUSBDEFS_H__
diff --git a/drivers/usb/musb/musbhdrc.h b/drivers/usb/musb/musbhdrc.h
index ec2a1af..0b874d6 100644
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
+ * NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY DIRECT, INDIRECT,
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
diff --git a/drivers/usb/musb/musbhsdma.c b/drivers/usb/musb/musbhsdma.c
index 5b6a42f..864ede0 100644
--- a/drivers/usb/musb/musbhsdma.c
+++ b/drivers/usb/musb/musbhsdma.c
@@ -1,35 +1,35 @@
-/******************************************************************
+/*
+ * MUSB OTG driver internal DMA controller support
+ *
  * Copyright 2005 Mentor Graphics Corporation
  * Copyright (C) 2005-2007 by Texas Instruments
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
- ******************************************************************/
+ * THIS SOFTWARE IS PROVIDED "AS IS" AND ANY EXPRESS OR IMPLIED
+ * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
+ * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
+ * NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY DIRECT, INDIRECT,
+ * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF
+ * USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
+ * ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
+ * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ */
 
 /*
  * Implementation for the DMA controller within the MUSBMHDRC.
diff --git a/drivers/usb/musb/plat_arc.h b/drivers/usb/musb/plat_arc.h
index 06d3f37..daefaaa 100644
--- a/drivers/usb/musb/plat_arc.h
+++ b/drivers/usb/musb/plat_arc.h
@@ -1,38 +1,35 @@
-/******************************************************************
+/*
+ * MUSB OTG driver Linux-specific architecture defines
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
+ * NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY DIRECT, INDIRECT,
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
- ******************************************************************/
-
-/*
- * Linux-specific architecture definitions
  */
 
 #ifndef __MUSB_LINUX_PLATFORM_ARCH_H__
diff --git a/drivers/usb/musb/plat_uds.c b/drivers/usb/musb/plat_uds.c
index 348c246..94f451e 100644
--- a/drivers/usb/musb/plat_uds.c
+++ b/drivers/usb/musb/plat_uds.c
@@ -1,36 +1,36 @@
-/*****************************************************************
+/*
+ * MUSB OTG driver core code
+ *
  * Copyright 2005 Mentor Graphics Corporation
  * Copyright (C) 2005-2006 by Texas Instruments
- * Copyright (C) 2006 by Nokia Corporation
- *
- * This file is part of the Inventra Controller Driver for Linux.
+ * Copyright (C) 2006-2007 Nokia Corporation
  *
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
- ******************************************************************/
+ * THIS SOFTWARE IS PROVIDED "AS IS" AND ANY EXPRESS OR IMPLIED
+ * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
+ * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
+ * NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY DIRECT, INDIRECT,
+ * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF
+ * USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
+ * ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
+ * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ */
 
 /*
  * Inventra (Multipoint) Dual-Role Controller Driver for Linux.
diff --git a/drivers/usb/musb/virthub.c b/drivers/usb/musb/virthub.c
index 5cbce32..3ad3bc3 100644
--- a/drivers/usb/musb/virthub.c
+++ b/drivers/usb/musb/virthub.c
@@ -1,36 +1,36 @@
-/*****************************************************************
+/*
+ * MUSB OTG driver virtual hub support
+ *
  * Copyright 2005 Mentor Graphics Corporation
  * Copyright (C) 2005-2006 by Texas Instruments
- * Copyright (C) 2006 by Nokia Corporation
- *
- * This file is part of the Inventra Controller Driver for Linux.
+ * Copyright (C) 2006-2007 Nokia Corporation
  *
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
+ * NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY DIRECT, INDIRECT,
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
- ******************************************************************/
+ */
 
 #include <linux/module.h>
 #include <linux/kernel.h>
-- 
1.5.2.3
