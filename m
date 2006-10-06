From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: porting linux on OMAP1510
Date: Fri, 06 Oct 2006 16:52:43 +0200
Message-ID: <45266DBB.7050201@gmail.com>
References: <20061006114855.19470.qmail@web34903.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <20061006114855.19470.qmail@web34903.mail.mud.yahoo.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: rajesh B <trytorajesh@yahoo.com>
Cc: Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

rajesh B wrote:
> am porting linux on OMAP1510...
> 1. am getting errors in kernal compilation....i didnt get the image what to do....
> 2. i thought to change the kernel version ....
> 
> am using this packages
> linux-2.4.19.tar.gz 
> patch-2.4.19-rmk7.bz2 
> patch-2.4.19-rmk7-omap1.bz2 
> 
> if i want to change linux to 2.4.20 then i have to change patch files also or not...

Try to use 2.6, 2.4 is outdated, especially for new 
projects. See Linux ARM kernel list FAQ:

http://www.arm.linux.org.uk/mailinglists/faq.php#f11

With 2.6 OMAP1510 should work without any porting.

Dirk
