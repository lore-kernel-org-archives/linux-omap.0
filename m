From: "shaunak saha" <reach2shaunak@gmail.com>
Subject: socket programme gives "operation not permitted"
Date: Wed, 26 Dec 2007 16:25:05 +0530
Message-ID: <e994cb210712260255i7456c6bbw791baf2d4fb3ce6f@mail.gmail.com>
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
To: Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi all,

 I m trying to execute a socket program.My code is only executing a
"socket(AF_UNIX, SOCK_STREAM, 0)" and "bind" system call.I m using struct
sockaddr_un where sun_family i m setting to PF_UNIX and sun_path to /opt
before calling bind.
When i do it in path /opt bind fails but in /tmp it is able to bind.I m
executing the code as root so have full permission in /opt.I m able to do al
file operation in /opt.
The "perror" system call in /opt shows "bind: Operation not permitted"

I m not able to understand why this is happenning.Can any one please help

Thanks in advance.

Regards,
Shaunak
