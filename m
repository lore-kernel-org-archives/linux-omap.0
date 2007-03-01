From: "Trilok Soni" <soni.trilok@gmail.com>
Subject: [PATCH 0/4 take2] OMAP MMU framework patches
Date: Thu, 1 Mar 2007 15:16:02 +0530
Message-ID: <5d5443650703010146h66c4af40wd632dcafb2dd951b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
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
To: linux-omap-open-source@linux.omap.com
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
List-Id: linux-omap@vger.kernel.org

These four patches is based on OMAP MMU framework developed by Paul Mundt,
Doyu-San and Toshihiro San. Let me know if there are any changes
required to it.

Additional changes:

- "struct class_device" to "struct device" conversion and made it compile :-)
- Add MMU_FWK and MBOX_FWK KConfig options
- Make MMU fwk to compile as module.

Tested only on H4, I don't have OMAP1 based board or N770. These
patches should be applied after the following patch:

http://linux.omap.com/pipermail/linux-omap-open-source/2007-February/009092.html

-- 
--Trilok Soni
