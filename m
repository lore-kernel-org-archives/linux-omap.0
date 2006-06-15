From: "Sergey Vointsev" <vointsev@gmail.com>
Subject: Re: telnet server
Date: Thu, 15 Jun 2006 17:17:59 +0400
Message-ID: <9713be7f0606150617w51f6c4d2uaf0e45c3d4877f57@mail.gmail.com>
References: <14ACE099F888004586603AEC0A559C2E24FE98@DLEE09.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <14ACE099F888004586603AEC0A559C2E24FE98@DLEE09.ent.ti.com>
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

Thanks for quick response!

I've installed inetd and it works well - it calls in.telnetd when
incoming connectiong appears.
But some problem occurred with telnet server. When I try to telnet to
OMAP I see such message
------------------
d5277@debian:~/work/linux-2.6.16$ telnet 192.168.0.99
Trying 192.168.0.99...
Connected to 192.168.0.99.
Escape character is '^]'.
telnetd: getpty: No such file or directory
.
Connection closed by foreign host.
------------------
I googled a little and found a number of similar situations, where
people were advised to check /det/pts. I executed
----
mkdir /dev/pts
mount -t devpts -o gid=5,mode=620 /dev/pts /dev/pts
----
and got devpts mounted, but problem with server remains.

Please advise.


-- 
Also available for instant messaging via Google Talk.
Need invite to Gmail? I have one for you! Just ask.
