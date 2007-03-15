From: "Cliff Brake" <cliff.brake@gmail.com>
Subject: Re: Regarding use of DirectFB
Date: Thu, 15 Mar 2007 13:09:54 -0400
Message-ID: <f96d234e0703151009t112ee8a7uac2c1a7489817118@mail.gmail.com>
References: <20070309140650.GC4399@bitbox.mine.nu>
	<fb249edb0703090623o367ec663h85dc581644cb258d@mail.gmail.com>
	<45F7F6D4.20203@gmail.com> <20070314170952.GB10230@bitbox.mine.nu>
	<002801c7669f$d0fe2be0$c7a3580a@swcenter.sec.samsung.co.kr>
	<20070315102325.GA4555@bitbox.mine.nu>
	<10043.59.144.85.207.1173968602.squirrel@mail.sqlstar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <10043.59.144.85.207.1173968602.squirrel@mail.sqlstar.com>
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
To: Raja Mallik <raja.mallik@sqlstar.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On 3/15/07, Raja Mallik <raja.mallik@sqlstar.com> wrote:

> I am working on to run some DirectFB application on my board that has
> omap5912  core. I am using linux-2.6.20 git kernel port and arm toolchain
> built with gcc-4.1.2, bin utils-2.17, glibc-2.5.
>
> We found that Ti' omap frame buffer is working fine.
> Has there been any port of directfb applications running on omap5912?

http://openembedded.org supports directfb, and I have heard reports
that people are successfully using it on PXA270 based systems.  I
suspect directfb apps would also run fine on omap.

Cliff

-- 
=======================
Cliff Brake
http://bec-systems.com
