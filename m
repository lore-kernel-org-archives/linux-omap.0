From: "Amit Gupta" <amit_jobs05@inbox.com>
Subject: Re: USB functionality on OMAP2430 SDP
Date: Fri, 20 Jul 2007 00:18:52 +0530
Message-ID: <78d6ed630707191148y75c3fb59m522dba6e99b45b8a@mail.gmail.com>
References: <20070704142900.67B087AF01@ws5-10.us4.outblaze.com>
	<78d6ed630707171140u7358c429v37d1869155748f60@mail.gmail.com>
	<78d6ed630707181300w366ed86xcdac8e8935ed856c@mail.gmail.com>
	<782515bb0707181613o1240f75cr5262ebdf9ff4788d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <782515bb0707181613o1240f75cr5262ebdf9ff4788d@mail.gmail.com>
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
Cc: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hi Nishant/all

Mine is OMAP2430 SPD v4.0 and I have an external transceiver ISP1301
for FSUSB port (J51) and I am not able to power on my port to make
it act as host ( 5 Volts is not available ).
I am connecting my mini AB port on J51 to mini B connector to
standard A connector (and std A connector connected to female to female
cable)
and USB mass storage device connected to other end of female cable.

And my mass storage device is not getting powered ON.

Can I configure it to host port ny software or do i need to
connect my mini AB port to mini A type cable (which I am not able
to get it unfortunately).


Thanks & Regards

Aman


On 7/19/07, nishanth menon <menon.nishanth@gmail.com> wrote:
>
> Aman,
> > The FS USB port 0 on OMAP2430 SDP is not acting as host i suppose
> Which version of the board are you using? On 5.0 2430SDP, to my
> understanding, the FSUSB and HSUSB transciever is Triton 2.
> Regards,
> Nishanth Menon
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>
