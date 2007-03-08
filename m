From: Ram <vshrirama@gmail.com>
Subject: Writing x-loader using u-boot.
Date: Thu, 8 Mar 2007 15:25:28 +0530
Message-ID: <8bf247760703080155x3474688ew85f7a3dbe9d2f477@mail.gmail.com>
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
List-Id: linux-omap@vger.kernel.org

Hi,
  Im using OMAP2430. Im trying to write x-loader using u-boot. for
some reason i dont want to use CSST.  I want to use u-boot only to
flash x-loader and u-boot (nand).

   u-boot nand - im able to write/read it back - no issues.

   I am able to write x-loader to nand flash using u-boot, i have
checked the contents of nand flash by reading it back. It is also same
as x-loader as written by CSST.

   But when i boot - it doesnt work?. Does CSST do anything special
other than writing it to nand flash?.

   Has anyone tried writing x-load using u-boot?

Regards,
sriram
