From: "Trilok Soni" <soni.trilok@gmail.com>
Subject: Re: Linux support for OMAP 850
Date: Tue, 20 Feb 2007 16:43:49 +0530
Message-ID: <5d5443650702200313l83f6fflee0279bfce894bfb@mail.gmail.com>
References: <2d51cbf80702182130q22e7110fw39c1b47ba9bc0eea@mail.gmail.com>
	<5d5443650702182149q4af0b2ady75849e995c6588cd@mail.gmail.com>
	<2d51cbf80702190036v5fe86864i6fffc1a36d54db2f@mail.gmail.com>
	<5d5443650702190411g1b968747n4c15166008f4f323@mail.gmail.com>
	<2d51cbf80702200306x66143ec4xea3d053210e9ea06@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <2d51cbf80702200306x66143ec4xea3d053210e9ea06@mail.gmail.com>
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
To: sandeep lahane <sandeep.lahane@gmail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Sandeep,

On 2/20/07, sandeep lahane <sandeep.lahane@gmail.com> wrote:
> I am working on OMAP 850 based custom board. I think in this case,
> apart from most of the generic drivers which might work (since 850 and
> 730 are similar), I might need to do some board specific stuff too.

Correct. You can leave most of the muxing/specific to your board like
initializations into your bootloader. Hope you have bootloader already
running on that custom board.

-- 
--Trilok Soni
