From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 0/3] Clean up SDRC usage; create sdrc.h
Date: Fri, 25 May 2007 02:25:47 -0600
Message-ID: <20070525082547.090170095@pwsan.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

These patches move all SDRC register defines into a common header
file, mach-omap2/sdrc.h.  They also add sdrc_{read,write}_reg()
functions to access or modify register contents.  Existing C code
referring to SDRC registers is modified to use sdrc.h.

These patches are prerequisites for the forthcoming PRCM cleanup
series.


- Paul

-- 
