From: Philip Balister <philip@balister.org>
Subject: Preparing an image for an OSK
Date: Tue, 03 Oct 2006 17:24:16 -0400
Message-ID: <4522D500.2060408@balister.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
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
To: OMAP <Linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

In the OSK newbies guide, it suggests that the kernel image you use to 
build the file that flashed is found in arch/arm/boot/compressed/vmlinux.

In the recent git kernels, I find vmlinux at the root of the kernel 
source after building. Is this still the file I feed to 
arm-linux-objcopy? I have built a very of kernels from git today and 
can't get anything to boot.

Philip
