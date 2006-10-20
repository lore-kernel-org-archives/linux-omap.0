From: Basavaraj Hiremath <hbasava@yahoo.com>
Subject: raw socket...
Date: Fri, 20 Oct 2006 06:28:56 -0700 (PDT)
Message-ID: <20061020132856.33807.qmail@web36114.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
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
To: Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,
I am writting an example program, to create a raw
socket on Fedora Core Linx.

When I create socket, my linux sustem crashes. I need
to powerdown the system. I am running this program as
super user to create raw socket.

Following line crashes..
rawSocket = socket(AF_INET, SOCK_RAW, IPPROTO_RAW);

Any insight on this will be great help.

Thanks & regards,
Raj



__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
