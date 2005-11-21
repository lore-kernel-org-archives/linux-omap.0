From: "xuxian" <lsfdxuxian@gmail.com>
Subject: RE: OSK 5912 can't execute file
Date: Mon, 21 Nov 2005 18:58:21 +0800
Message-ID: <4381a853.63005bbd.1ad2.7ba2@mx.gmail.com>
References: <003701c5ee80$0ca76a10$dc96718c@bluecan>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <003701c5ee80$0ca76a10$dc96718c@bluecan>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "'Laihui,Sun'" <laihui.ece93g@nctu.edu.tw>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,
Make sure the executable file 'hello' exist in /bin/ .

xuxian

-----Original Message-----
From: linux-omap-open-source-bounces@linux.omap.com
[mailto:linux-omap-open-source-bounces@linux.omap.com] On Behalf Of
Laihui,Sun
Sent: Monday, November 21, 2005 5:44 PM
To: linux-omap-open-source@linux.omap.com
Subject: OSK 5912 can't execute file

Hi, everyone:

My OMAP5912 platform is 2.6.12 kernel version.
I set up the nfs system and use the cross-compiler for a simple "hello"
file.
I know that some file may need the library file for executing file. 
I copy some lib file for it, but it still not work.
The error message is 

-sh: /bin/hello : not found 

Does anyone ever meet the same problem and also copy the needed lib file but
still can't work?
Or there may some other way to solve this problem?

Thank you very much.
Best Regards,
Laihui, Sun
_______________________________________________
Linux-omap-open-source mailing list
Linux-omap-open-source@linux.omap.com
http://linux.omap.com/mailman/listinfo/linux-omap-open-source
