From: "Juha Kuikka" <juha.kuikka@gmail.com>
Subject: CSST's load to ram feature
Date: Thu, 23 Aug 2007 18:25:04 -0700
Message-ID: <a46a26fd0708231825v3f95126fi2a53267ef6f46cb5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
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

TI's CSST too can, in addition to burning to flash memory, load binary
directly to RAM and execute it from there.

This feature works fine with the included example binaries but I am unable
to use it to run x-loader or u-boot.

I'm suspecting x-loader/u-boot do not work because they expect the system to
be in a certain state but it is not.

Has anybody else had this problem and more importantly found a solution to
it?

Thanks,
 Juha

-- 
Madness takes it's toll. Please have exact change.
