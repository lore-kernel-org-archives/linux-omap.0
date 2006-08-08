From: "Sergey Vointsev" <vointsev@gmail.com>
Subject: Re: Write to file
Date: Tue, 8 Aug 2006 12:25:43 +0400
Message-ID: <9713be7f0608080125r5f6e992fi30ad23287381ff30@mail.gmail.com>
References: <9713be7f0608070558g7be2c6c2hafdf0a76cd5298a@mail.gmail.com>
	<B3FDBBC0428C8145A83F312B740CE67D075831@si-mail48.de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <B3FDBBC0428C8145A83F312B740CE67D075831@si-mail48.de.bosch.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi, Nguyen!

As I understand, there aren't some special commands for read/write
files on OMAP. At least the following simple program worked fine on
both my desktop and my OSK5912:

********************
#include <stdio.h>
int main()
{
	FILE *f;
	f = fopen ("/tmp/testfile","a+");
	fprintf (f,"Hello! \n");
	fclose (f);
	return 0;
}
********************

I have rootfs mounted via NFS, but I believe it doesn't really matter.
So you should check the following things:
1. is your filesystem mounted in rw mode or only for reading
2. does you program have permissons (chmod/chown I mean) for writing
to the directory you use

Sergey.
