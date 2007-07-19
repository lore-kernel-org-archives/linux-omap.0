From: "nishanth menon" <menon.nishanth@gmail.com>
Subject: Re: USB functionality on OMAP2430 SDP
Date: Thu, 19 Jul 2007 18:16:11 -0500
Message-ID: <782515bb0707191616w71a8898fje4f2a1f28833e1e3@mail.gmail.com>
References: <20070704142900.67B087AF01@ws5-10.us4.outblaze.com>
	<78d6ed630707171140u7358c429v37d1869155748f60@mail.gmail.com>
	<78d6ed630707181300w366ed86xcdac8e8935ed856c@mail.gmail.com>
	<782515bb0707181613o1240f75cr5262ebdf9ff4788d@mail.gmail.com>
	<78d6ed630707191148y75c3fb59m522dba6e99b45b8a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <78d6ed630707191148y75c3fb59m522dba6e99b45b8a@mail.gmail.com>
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
To: Amit Gupta <amit_jobs05@inbox.com>
Cc: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Aman, Kangesh,
Gentle request: Please dont TOP post... if you use gmail, and open the
mail... I spend 10 seconds for scrolling down to the next email -
multiply me with 1k users or so on this list.... Please refer to
http://www.arm.linux.org.uk/mailinglists/etiquette.php.

On 7/19/07, Amit Gupta <amit_jobs05@inbox.com> wrote:
> Mine is OMAP2430 SPD v4.0 and I have an external transceiver ISP1301
> for FSUSB port (J51) and I am not able to power on my port to make
> it act as host ( 5 Volts is not available ).
> I am connecting my mini AB port on J51 to mini B connector to
> standard A connector (and std A connector connected to female to female
> cable)
> and USB mass storage device connected to other end of female cable.
I am no expert in USB... but, I think you need to check up on the
quick start guide for the SDP, see the descriptions of S6-2, S6-6 and
S6-7 of these S6-6 is important since it makes a decision to route
FSUSB signals either to T2 or legacy (1301).
I have a 5.0 SDP and glanced at a 4.0 board, and J51 looks very much
tagged with a silk screen label as HSUSB port. The HSUSB lines from
OMAP are connected to 1504 to my knowledge - so no use connecting
there.. try the port next to it.. near the 2 line character LCD. if u
can get ur gadget mode working in FSUSB over 1301.. then  u'd know the
port is working at least..

Regards,
Nishanth Menon
