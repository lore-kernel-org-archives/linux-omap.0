From: Hiroki Kaminaga <kaminaga@sm.sony.co.jp>
Subject: [RFC] Snapshot boot for OSK5912
Date: Tue, 11 Jul 2006 20:04:52 +0900 (JST)
Message-ID: <20060711.200452.92582959.kaminaga@sm.sony.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
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
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

I made a page describing snapshot boot. Patch and instructions are
available here:

http://tree.celinuxforum.org/CelfPubWiki/SuspendToDiskForARM

Snapshot boot is essentially a resume-from-disk operation, which is a
system resume from a semi-permanent snapshot image stored on flash
memory for OSK5912, that restores the machine to a known running
state. As opposed to a standard resume operation, a snapshot image is
made only once, stored on flash memory, and same image is used
repeatedly, every time the system is powered on.

The purpose of this is to achieve faster startup time of linux on
OSK5912. It is still OSK5912 specific, but would like to hear
comments.


Best Regards,

(Hiroki Kaminaga)
t
--
