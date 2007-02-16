From: Jens Bretschneider <jens.bretschneider@nxp.com>
Subject: Re: Problems retrieving the OMAP linux GIT database
Date: Fri, 16 Feb 2007 09:18:05 +0100
Message-ID: <OF92175994.434FF19B-ONC1257284.002D3736-C1257284.002D8BA4@philips.com>
References: <OF161AF1FF.F7934E02-ONC1257283.005C20CE-C1257283.005CC773@philips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <OF161AF1FF.F7934E02-ONC1257283.005C20CE-C1257283.005CC773@philips.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Jens Bretschneider <jens.bretschneider@nxp.com>
Cc: linux-omap-open-source-bounces@linux.omap.com, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Could someone just be so kind and confirm that the used URL for 
downloading the sourcetree is right? Is there any other feasible way if 
HTTP does not work? 
Has someone encountered the same problems?

http://source.mvista.com/gittrees/linux-omap-2.6.git 

Many thanks!

Jens Bretschneider 
 










Jens Bretschneider <jens.bretschneider@nxp.com> 
Sent by:
linux-omap-open-source-bounces@linux.omap.com
2007-02-15 17:54

To
linux-omap-open-source@linux.omap.com
cc

Subject
Problems retrieving the OMAP linux GIT database
Classification







Hi,

I am trying to build my local GIT database for OMAP development. When I am 

using GIT 1.5.0 or even GIT 1.4.4, I get an error after a couple of 100MBs 

... and the downloaded data is useless. What I have done is:

git clone http://source.mvista.com/gittrees/linux-omap-2.6.git 
linux-omap-2.6-mv
...
walk 712622ef081d84ab8523767dbd2e824b9e077919
walk f6bb6492db52c1d82e89321bf7790846a3ae9e2b
error: Couldn't get 
http://source.mvista.com/gittrees/linux-omap-2.6.git/refs/heads/old for 
heads/old
The requested URL returned error: 404
error: Could not interpret heads/old as something to pull
Wed Feb 14 20:21:02 CET 2007

Any idea what I am dong wrong? Direct internet access is not possible, I 
have to use an HTTP proxy.


Regards,

Jens Bretschneider



_______________________________________________
Linux-omap-open-source mailing list
Linux-omap-open-source@linux.omap.com
http://linux.omap.com/mailman/listinfo/linux-omap-open-source
