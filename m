From: "nishanth menon" <menon.nishanth@gmail.com>
Subject: Re: NFS Root File system and C File operation
Date: Fri, 4 May 2007 19:03:34 -0500
Message-ID: <782515bb0705041703m5a0f94bes28a197c4847490ab@mail.gmail.com>
References: <E98CB0DA71F20341907598C3494F320D06CD75@BLR-EC-MBX08.wipro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <E98CB0DA71F20341907598C3494F320D06CD75@BLR-EC-MBX08.wipro.com>
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
To: "anupam.mahajan@wipro.com" <anupam.mahajan@wipro.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Anupam,
On 5/4/07, anupam.mahajan@wipro.com <anupam.mahajan@wipro.com> wrote:
> /rootfs ). Once Linux kernel is up on Target, root file system can be seen using "ls" command - bin, sbin, tmp, usr, etc ......... so on.
Looks like ur fs is fine...
> Now, when checking  the file in /tmp diectory, the file created from the Application is present with 0 bytes. This means write operation didn't happen.
Try the following commands:
echo "test 123456">/tmp/abc.txt
cat /tmp/abc.txt

If you see "test 123456" then ur fs is perfect.. fix ur app.

Regards,
Nishanth Menon
