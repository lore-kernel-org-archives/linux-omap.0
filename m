From: Hiroki Kaminaga <kaminaga@sm.sony.co.jp>
Subject: Re: changing core frequency in omap 5912
Date: Mon, 13 Feb 2006 17:19:29 +0900 (JST)
Message-ID: <20060213.171929.71083169.kaminaga@sm.sony.co.jp>
References: <8bf247760602122220y2abfab6eraddf56fc82ef1840@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <u-boot-users-admin@lists.sourceforge.net>
In-Reply-To: <8bf247760602122220y2abfab6eraddf56fc82ef1840@mail.gmail.com>
Sender: u-boot-users-admin@lists.sourceforge.net
Errors-To: u-boot-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/u-boot-users>,
	<mailto:u-boot-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:u-boot-users@lists.sourceforge.net>
List-Help: <mailto:u-boot-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/u-boot-users>,
	<mailto:u-boot-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=u-boot-users>
To: vshrirama@gmail.com
Cc: linux-omap-open-source@linux.omap.com, u-boot-users@lists.sourceforge.net
List-Id: linux-omap@vger.kernel.org

Hi,

>     How do i change the cpu core frequency in omap 5912.
> 
>     I tried changing the DPLL registers. but u-boot hangs.

writing clock control value(0x050f) to address(0xfffece00)?


HK.
--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
