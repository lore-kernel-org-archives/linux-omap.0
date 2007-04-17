From: "Budhee Jamaich" <budheej@gmail.com>
Subject: Re: cross compiling for OMAP2430
Date: Tue, 17 Apr 2007 16:51:34 +0300
Message-ID: <57314e840704170651r298a4a7fl89a121c380828f18@mail.gmail.com>
References: <782515bb0704170616w6fe8e474q2dded08e31d1e409@mail.gmail.com>
	<B62D67BD8EC3324C8A3DACEEA1A0D6C6012B8B51@dlee12.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <B62D67BD8EC3324C8A3DACEEA1A0D6C6012B8B51@dlee12.ent.ti.com>
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
To: "Kipisz, Steven" <s-kipisz2@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi Steve and Nishanth,

On 4/17/07, Kipisz, Steven <s-kipisz2@ti.com> wrote:
> Hi Budhee,
> I agree with Nishanth.  I usually try to ./configure --help to see if
> cross compiling is available.  If so, you typically do
> ./configure --target=arm-linux --build=i386-pc-linux --host=arm-linux

can you plz explain what is each flag ? let's say my host (where I compile
the application) is a normal i386 PC, and the target is OMAP2430,
then are these the correct flags ?

> Another trick is
> CC=arm-linux-gcc ./configure

why do I need to use arm-linux-gcc ? can't the standard gcc compile for arm ?

Thank YOu
Budhee
